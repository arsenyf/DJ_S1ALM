function populate_video()
close all;
populate(EXP.TrackingTrial);
populate(EXP.VideoFiducialsTrial);
populate(ANL.VideoLandmarksSession);
populate(ANL.VideoTongueTrial);
populate(ANL.Video1stLickTrial);

populate(ANL.VideoLickNumberTrial);

populate(ANL.LickDirectionTrial);
populate(ANL.VideoTongueValidRTTrial);
populate(ANL.Video1stLickTrialNormalized);

populate(ANL.RegressionTongueSingleUnit);
populate(ANL.RegressionProjTrial);
populate(ANL.RegressionDecoding);
populate(ANL.RegressionDecodingSignificant);
populate(RegressionDecodingLickNumber);
populate(ANL.RegressionRotation);

populate(ANL.UnitTongue1DTuning)
populate(ANL.UnitTongue1DTuningShuffling)
populate(ANL.UnitTongue1DTuningSignificance)

populate(ANL.UnitTongue1DTuningReconstruction)
populate(ANL.UnitTongue2DTuning);