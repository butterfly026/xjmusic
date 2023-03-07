package io.xj.ship.broadcast;

import io.xj.lib.app.AppEnvironment;
import io.xj.lib.filestore.FileStoreProvider;
import io.xj.lib.notification.NotificationProvider;
import io.xj.ship.source.SegmentAudioManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.sound.sampled.AudioFormat;

@Service
public class BroadcastFactoryImpl implements BroadcastFactory {
  private final AppEnvironment env;
  private final PlaylistPublisher playlistPublisher;
  private final FileStoreProvider fileStoreProvider;
  private final NotificationProvider notificationProvider;
  private final SegmentAudioManager segmentAudioManager;

  @Autowired
  public BroadcastFactoryImpl(
    AppEnvironment env,
    PlaylistPublisher playlistPublisher,
    FileStoreProvider fileStoreProvider,
    NotificationProvider notificationProvider,
    SegmentAudioManager segmentAudioManager
  ) {
    this.env = env;
    this.playlistPublisher = playlistPublisher;
    this.fileStoreProvider = fileStoreProvider;
    this.notificationProvider = notificationProvider;
    this.segmentAudioManager = segmentAudioManager;
  }

  @Override
  public StreamEncoder encoder(String shipKey, AudioFormat format, Long initialSeqNum) {
    return new StreamEncoderImpl(shipKey, format, initialSeqNum, env, fileStoreProvider, playlistPublisher);
  }

  @Override
  public ChunkMixer mixer(Chunk chunk, AudioFormat format) {
    return new ChunkMixerImpl(format, chunk, notificationProvider, segmentAudioManager, env);
  }

  @Override
  public StreamPlayer player(AudioFormat format) {
    return new StreamPlayerImpl(format, env);
  }

  @Override
  public StreamWriter writer(AudioFormat format) {
    return new StreamWriterImpl(format, env);
  }
}
