// Copyright (c) XJ Music Inc. (https://xjmusic.com) All Rights Reserved.

package io.xj.gui.controllers;

import io.xj.gui.ProjectModalController;
import io.xj.gui.services.FabricationService;
import io.xj.gui.services.LabService;
import io.xj.gui.services.ProjectService;
import io.xj.gui.services.ThemeService;
import io.xj.gui.services.UIStateService;
import io.xj.gui.utils.ProjectUtils;
import io.xj.gui.utils.TextUtils;
import io.xj.hub.tables.pojos.Project;
import io.xj.hub.util.StringUtils;
import javafx.application.Platform;
import javafx.beans.binding.Bindings;
import javafx.beans.property.ObjectProperty;
import javafx.beans.property.SimpleDoubleProperty;
import javafx.beans.property.SimpleObjectProperty;
import javafx.beans.value.ObservableBooleanValue;
import javafx.collections.FXCollections;
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.ChoiceBox;
import javafx.scene.control.Tab;
import javafx.scene.control.TabPane;
import javafx.scene.control.TextField;
import javafx.scene.control.ToggleButton;
import javafx.scene.control.ToggleGroup;
import javafx.scene.image.ImageView;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.VBox;
import javafx.stage.Stage;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;

import java.util.Comparator;
import java.util.Map;
import java.util.Objects;

@Service
public class ProjectCreationModalController extends ProjectModalController {
  static final Map<ProjectCreationMode, String> WINDOW_TITLE = Map.of(
    ProjectCreationMode.NEW_PROJECT, "Create New Project",
    ProjectCreationMode.CLONE_PROJECT, "Clone Project"
  );
  private final SimpleDoubleProperty demoImageSize = new SimpleDoubleProperty(120);
  private final FabricationService fabricationService;
  private final LabService labService;
  private final ObjectProperty<ProjectCreationMode> mode = new SimpleObjectProperty<>(ProjectCreationMode.NEW_PROJECT);
  private final ObservableBooleanValue isDemoVisible = Bindings.createBooleanBinding(
    () -> mode.get() == ProjectCreationMode.CLONE_PROJECT, mode
  );
  private final ObjectProperty<Project> selectedProject = new SimpleObjectProperty<>();

  @FXML
  VBox container;

  @FXML
  TextField fieldProjectName;

  @FXML
  TextField fieldPathPrefix;

  @FXML
  Button buttonSelectDirectory;

  @FXML
  Button buttonOK;

  @FXML
  Button buttonCancel;

  @FXML
  ImageView demoImageVgm;

  @FXML
  ImageView demoImageBump;

  @FXML
  ImageView demoImageSlaps;

  @FXML
  ImageView demoImageSpace;

  @FXML
  ToggleGroup demoSelection;

  @FXML
  ToggleButton buttonDemoVgm;

  @FXML
  ToggleButton buttonDemoBump;

  @FXML
  ToggleButton buttonDemoSlaps;

  @FXML
  ToggleButton buttonDemoSpace;

  @FXML
  VBox demoContainer;

  @FXML
  TabPane tabPane;

  @FXML
  Tab tabLab;

  @FXML
  Tab tabDemo;

  @FXML
  ChoiceBox<ProjectChoice> choiceCloneProject;

  public ProjectCreationModalController(
    @Value("classpath:/views/project-creation-modal.fxml") Resource fxml,
    ConfigurableApplicationContext ac,
    UIStateService uiStateService,
    ProjectService projectService,
    FabricationService fabricationService,
    ThemeService themeService,
    LabService labService
  ) {
    super(fxml, ac, themeService, uiStateService, projectService);
    this.fabricationService = fabricationService;
    this.labService = labService;
  }

  @Override
  public void onStageReady() {
    // Add slash to end of "file output projectFilePath prefix"
    // https://www.pivotaltracker.com/story/show/186555998
    fieldPathPrefix.textProperty().bindBidirectional(projectService.basePathPrefixProperty());
    fieldPathPrefix.focusedProperty().addListener((obs, wasFocused, isNowFocused) -> {
      if (!isNowFocused) {
        TextUtils.addTrailingSlash(fieldPathPrefix);
      }
    });

    demoContainer.visibleProperty().bind(isDemoVisible);
    demoContainer.managedProperty().bind(isDemoVisible);
    demoImageVgm.fitHeightProperty().bind(demoImageSize);
    demoImageVgm.fitWidthProperty().bind(demoImageSize);
    demoImageBump.fitHeightProperty().bind(demoImageSize);
    demoImageBump.fitWidthProperty().bind(demoImageSize);
    demoImageSlaps.fitHeightProperty().bind(demoImageSize);
    demoImageSlaps.fitWidthProperty().bind(demoImageSize);
    demoImageSpace.fitHeightProperty().bind(demoImageSize);
    demoImageSpace.fitWidthProperty().bind(demoImageSize);

    if (uiStateService.isLabFeatureEnabledProperty().get()) {
      tabLab.disableProperty().bind(labService.isAuthenticated().not());
    } else {
      tabPane.getTabs().remove(tabLab);
    }

    if (labService.isAuthenticated().get()) {
      labService.fetchProjects(projects -> choiceCloneProject.setItems(FXCollections.observableList(projects.stream().sorted(Comparator.comparing(Project::getName)).map(ProjectChoice::new).toList())));
      choiceCloneProject.setOnAction(event -> {
        ProjectChoice choice = choiceCloneProject.getValue();
        if (Objects.nonNull(choice)) {
          selectedProject.set(choice.project());
          if (StringUtils.isNullOrEmpty(fieldProjectName.getText()))
            fieldProjectName.setText(choice.project().getName());
        }
      });
    }
  }

  @Override
  public void onStageClose() {
    // no op
  }

  @Override
  public void launchModal() {
    projectService.promptToSaveChanges(() -> createAndShowModal(WINDOW_TITLE.get(mode.get())));
  }

  /**
   Set the mode for project creation, e.g. New Project vs Clone Project

   @param mode of project creation
   */
  public void setMode(ProjectCreationMode mode) {
    this.mode.set(mode);
  }

  @FXML
  void handlePressSelectDirectory() {
    var path = ProjectUtils.chooseDirectory(
      buttonSelectDirectory.getScene().getWindow(), "Choose destination folder", fieldPathPrefix.getText()
    );
    if (Objects.nonNull(path)) {
      fieldPathPrefix.setText(TextUtils.addTrailingSlash(path));
    }
  }

  @FXML
  void handlePressOK() {
    var projectName = fieldProjectName.getText().replaceAll("[^a-zA-Z0-9 ]", "");

    if (Objects.equals(mode.get(), ProjectCreationMode.CLONE_PROJECT)
      && Objects.isNull(demoSelection.getSelectedToggle())
      && Objects.isNull(selectedProject.get())) {
      projectService.showWarningAlert(
        "Cannot clone project",
        "Must select a project to clone.",
        "Select either a Demo project or, if authenticated, a project from the Lab."
      );
      return;
    }

    if (StringUtils.isNullOrEmpty(projectName)) {
      projectService.showWarningAlert(
        "Cannot create project",
        "Project name is required.",
        "Please enter a name for the project."
      );
      return;
    }

    fabricationService.cancel();
    Platform.runLater(() -> {
      switch (mode.get()) {
        case CLONE_PROJECT -> {
          if (tabDemo.isSelected()) {
            projectService.cloneFromDemoTemplate(fieldPathPrefix.getText(), ((ToggleButton) demoSelection.getSelectedToggle()).getId(), projectName);
          } else {
            projectService.cloneFromLabProject(fieldPathPrefix.getText(), selectedProject.getValue().getId(), projectName);
          }
        }
        case NEW_PROJECT -> projectService.createProject(fieldPathPrefix.getText(), projectName);
      }

      Stage stage = (Stage) buttonOK.getScene().getWindow();
      stage.close();
      onStageClose();
    });
  }

  @FXML
  void handlePressCancel() {
    Stage stage = (Stage) buttonCancel.getScene().getWindow();
    stage.close();
    onStageClose();
  }

  @FXML
  void handleDemoPressedVgm(MouseEvent ignored) {
    if (StringUtils.isNullOrEmpty(fieldProjectName.getText()))
      fieldProjectName.setText("Video Game Demo");
    buttonDemoVgm.setSelected(true);
  }

  @FXML
  void handleDemoPressedBump(MouseEvent ignored) {
    if (StringUtils.isNullOrEmpty(fieldProjectName.getText()))
      fieldProjectName.setText("Deep House Demo");
    buttonDemoBump.setSelected(true);
  }

  @FXML
  void handleDemoPressedSlaps(MouseEvent ignored) {
    if (StringUtils.isNullOrEmpty(fieldProjectName.getText()))
      fieldProjectName.setText("Lofi Hip Hop Demo");
    buttonDemoSlaps.setSelected(true);
  }

  @FXML
  void handleDemoPressedSpace(MouseEvent ignored) {
    if (StringUtils.isNullOrEmpty(fieldProjectName.getText()))
      fieldProjectName.setText("Ambient Flow Demo");
    buttonDemoSpace.setSelected(true);
  }

  /**
   This class is used to display the project name in the ChoiceBox while preserving the underlying ID
   */
  public record ProjectChoice(Project project) {
    @Override
    public String toString() {
      return Objects.nonNull(project) ? project.getName() : "Select...";
    }
  }
}
