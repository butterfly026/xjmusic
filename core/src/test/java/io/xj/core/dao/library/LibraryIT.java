// Copyright (c) 2020, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.core.dao.library;

import com.google.common.collect.ImmutableList;
import io.xj.core.FixtureIT;
import io.xj.core.access.Access;
import io.xj.core.dao.LibraryDAO;
import io.xj.core.exception.CoreException;
import io.xj.core.model.Account;
import io.xj.core.model.Instrument;
import io.xj.core.model.InstrumentState;
import io.xj.core.model.InstrumentType;
import io.xj.core.model.Library;
import io.xj.core.model.Program;
import io.xj.core.model.ProgramState;
import io.xj.core.model.ProgramType;
import io.xj.core.model.User;
import org.assertj.core.util.Lists;
import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;

import java.util.Collection;
import java.util.Iterator;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertSame;

public class LibraryIT extends FixtureIT {
  @Rule
  public ExpectedException failure = ExpectedException.none();
  private LibraryDAO testDAO;
  private Library library1a;
  private Account account2;
  private Library library2a;
  private Library library2b;
  private Library library1b;

  @Before
  public void setUp() throws Exception {
    reset();

    // Account "palm tree" has library "leaves" and library "coconuts"
    account1 = insert(Account.create("palm tree"));
    library1a = insert(Library.create(account1, "leaves", now()));
    library1b = insert(Library.create(account1, "coconuts", now()));

    // Account "boat" has library "helm" and library "sail"
    account2 = insert(Account.create("boat"));
    library2a = insert(Library.create(account2, "helm", now()));
    library2b = insert(Library.create(account2, "sail", now()));

    // Instantiate the test subject
    testDAO = injector.getInstance(LibraryDAO.class);
  }

  @Test
  public void create() throws Exception {
    Access access = Access.create("Admin");
    Library inputData = new Library()
      .setName("coconuts")
      .setAccountId(account1.getId());

    Library result = testDAO.create(access, inputData);

    assertNotNull(result);
    assertEquals(account1.getId(), result.getAccountId());
    assertEquals("coconuts", result.getName());
  }

  /**
   [#155089641] Engineer expects to be able to of and update a Library.
   */
  @Test
  public void create_asEngineer() throws Exception {
    Access access = Access.create(ImmutableList.of(account1), "Engineer");
    Library inputData = new Library()
      .setName("coconuts")
      .setAccountId(account1.getId());

    Library result = testDAO.create(access, inputData);

    assertNotNull(result);
    assertEquals(account1.getId(), result.getAccountId());
    assertEquals("coconuts", result.getName());
  }

  /**
   [#155089641] Engineer expects to be able to of and update a Library.
   */
  @Test
  public void create_asEngineer_failsWithoutAccountAccess() throws Exception {
    Access access = Access.create(ImmutableList.of(Account.create()), "Engineer");
    Library inputData = new Library()
      .setName("coconuts")
      .setAccountId(account1.getId());

    failure.expect(CoreException.class);
    failure.expectMessage("does not exist");

    testDAO.create(access, inputData);
  }

  @Test
  public void create_FailsWithoutAccountID() throws Exception {
    Access access = Access.create("Admin");
    Library inputData = new Library()
      .setName("coconuts");

    failure.expect(CoreException.class);
    failure.expectMessage("Account ID is required");

    testDAO.create(access, inputData);
  }

  @Test
  public void readOne() throws Exception {
    Access access = Access.create(ImmutableList.of(account1), "User");

    Library result = testDAO.readOne(access, library1b.getId());

    assertNotNull(result);
    assertEquals(library1b.getId(), result.getId());
    assertEquals(account1.getId(), result.getAccountId());
    assertEquals("coconuts", result.getName());
  }

  @Test
  public void readOne_FailsWhenUserIsNotInAccount() throws Exception {
    Access access = Access.create(ImmutableList.of(Account.create()), "User");
    failure.expect(CoreException.class);
    failure.expectMessage("does not exist");

    testDAO.readOne(access, account1.getId());
  }

  @Test
  public void readAll() throws Exception {
    Access access = Access.create(ImmutableList.of(account1), "User");

    Collection<Library> result = testDAO.readMany(access, ImmutableList.of(account1.getId()));

    assertEquals(2L, result.size());
    Iterator<Library> resultIt = result.iterator();
    assertEquals("leaves", resultIt.next().getName());
    assertEquals("coconuts", resultIt.next().getName());
  }

  @Test
  public void readAll_fromAllAccounts() throws Exception {
    Access access = Access.create(ImmutableList.of(account1, account2), "User");

    Collection<Library> result = testDAO.readMany(access, Lists.newArrayList());

    assertEquals(4L, result.size());
    Iterator<Library> it = result.iterator();
    assertEquals("leaves", it.next().getName());
    assertEquals("coconuts", it.next().getName());
    assertEquals("helm", it.next().getName());
    assertEquals("sail", it.next().getName());
  }

  @Test
  public void readAll_SeesNothingOutsideOfAccount() throws Exception {
    Access access = Access.create(ImmutableList.of(Account.create()), "User");

    Collection<Library> result = testDAO.readMany(access, ImmutableList.of(account1.getId()));

    assertEquals(0L, result.size());
  }

  @Test
  public void update_FailsWithoutAccountID() throws Exception {
    Access access = Access.create("Admin");
    Library inputData = new Library()
      .setName("cannons");

    failure.expect(CoreException.class);
    failure.expectMessage("Account ID is required");

    testDAO.update(access, library1a.getId(), inputData);
  }

  @Test
  public void update_FailsWithoutName() throws Exception {
    Access access = Access.create("Admin");
    Library inputData = new Library()
      .setAccountId(account1.getId());

    failure.expect(CoreException.class);
    failure.expectMessage("Name is required");

    testDAO.update(access, library1a.getId(), inputData);
  }

  @Test
  public void update() throws Exception {
    Access access = Access.create("Admin");
    Library inputData = new Library()
      .setName("cannons")
      .setAccountId(account1.getId());

    testDAO.update(access, library1a.getId(), inputData);

    Library result = testDAO.readOne(Access.internal(), library1a.getId());
    assertNotNull(result);
    assertEquals("cannons", result.getName());
    assertEquals(account1.getId(), result.getAccountId());
  }

  /**
   [#155089641] Engineer expects to be able to of and update a Library.
   */
  @Test
  public void update_asEngineer() throws Exception {
    Access access = Access.create(ImmutableList.of(account1), "Engineer");
    Library inputData = new Library()
      .setName("cannons")
      .setAccountId(account1.getId());

    testDAO.update(access, library1a.getId(), inputData);

    Library result = testDAO.readOne(Access.internal(), library1a.getId());
    assertNotNull(result);
    assertEquals("cannons", result.getName());
    assertEquals(account1.getId(), result.getAccountId());
  }

  /**
   [#155089641] Engineer expects to be able to of and update a Library.
   */
  @Test
  public void update_asEngineer_failsWithoutAccountAccess() throws Exception {
    Access access = Access.create(ImmutableList.of(Account.create()), "Engineer");
    Library inputData = new Library()
      .setName("cannons")
      .setAccountId(account1.getId());

    failure.expect(CoreException.class);
    failure.expectMessage("does not exist");

    testDAO.update(access, library1a.getId(), inputData);
  }

  @Test
  public void update_FailsUpdatingToNonexistentAccount() throws Exception {
    Access access = Access.create("Admin");
    Library inputData = new Library()
      .setName("cannons")
      .setAccountId(account1.getId());

    try {
      testDAO.update(access, library1a.getId(), inputData);

    } catch (Exception e) {
      Library result = testDAO.readOne(Access.internal(), library1a.getId());
      assertNotNull(result);
      assertEquals("helm", result.getName());
      assertEquals(library1a.getId(), result.getAccountId());
      assertSame(CoreException.class, e.getClass());
    }
  }

  @Test
  public void update_Name() throws Exception {
    Access access = Access.create("Admin");
    Library inputData = new Library()
      .setName("cannons")
      .setAccountId(account2.getId());

    testDAO.update(access, library2a.getId(), inputData);

    Library result = testDAO.readOne(Access.internal(), library2a.getId());
    assertNotNull(result);
    assertEquals("cannons", result.getName());
    assertEquals(account2.getId(), result.getAccountId());
  }

  @Test
  public void update_NameAndAccount() throws Exception {
    Access access = Access.create("Admin");
    Library inputData = new Library()
      .setName("trunk")
      .setAccountId(account1.getId());

    testDAO.update(access, library1a.getId(), inputData);

    Library result = testDAO.readOne(Access.internal(), library1a.getId());
    assertNotNull(result);
    assertEquals("trunk", result.getName());
    assertEquals(account1.getId(), result.getAccountId());
  }

  @Test
  public void delete() throws Exception {
    Access access = Access.create("Admin");

    testDAO.destroy(access, library1a.getId());

    assertNotExist(testDAO, library1a.getId());
  }

  @Test
  public void delete_FailsIfLibraryHasProgram() throws Exception {
    Access access = Access.create("Admin");
    user101 = insert(User.create("bill", "bill@email.com", "http://pictures.com/bill.gif"));
    insert(Program.create(user101, library2b, ProgramType.Main, ProgramState.Published, "brilliant", "C#", 120.0, 0.6));

    try {
      testDAO.destroy(access, library2b.getId());
    } catch (Exception e) {
      Library result = testDAO.readOne(Access.internal(), library2b.getId());
      assertNotNull(result);
      assertSame(CoreException.class, e.getClass());
      assertEquals("Found Program in Library", e.getMessage());
    }
  }

  @Test
  public void delete_FailsIfLibraryHasInstrument() throws Exception {
    Access access = Access.create("Admin");
    user101 = insert(User.create("bill", "bill@email.com", "http://pictures.com/bill.gif"));
    insert(Instrument.create(user101, library2b, InstrumentType.Percussive, InstrumentState.Published, "brilliant"));

    try {
      testDAO.destroy(access, library2b.getId());
    } catch (Exception e) {
      Library result = testDAO.readOne(Access.internal(), library2b.getId());
      assertNotNull(result);
      assertSame(CoreException.class, e.getClass());
      assertEquals("Found Instrument in Library", e.getMessage());
    }
  }
}
