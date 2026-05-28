CREATE DATABASE MentalHealthDW;
USE MentalHealthDW;



CREATE TABLE DimUser (
    UID VARCHAR(10) PRIMARY KEY,
    gender NVARCHAR(10)
);


CREATE TABLE DimMental (
    MentalID INT IDENTITY(1,1) PRIMARY KEY,
    phq4_1 INT,
    phq4_2 INT,
    phq4_3 INT,
    phq4_4 INT,
    social_level INT,
    sse3_1 INT,
    sse3_2 INT,
    sse3_3 INT,
    sse3_4 INT,
    stress INT
);

-- 3️⃣ DimSleepMotion
CREATE TABLE DimSleepMotion (
    SleepMotionID INT IDENTITY(1,1) PRIMARY KEY,
    sleep_duration DECIMAL(10,2),
    sleep_start INT,
    sleep_end INT,
    sleep_start_time TIME,
    sleep_end_time TIME,
    act_in_vehicle_ep_avg DECIMAL(18,6),
    act_on_foot_ep_avg DECIMAL(18,6),
    act_still_ep_avg DECIMAL(18,6),
    loc_dist_ep_avg DECIMAL(18,6)
);

-- 4️⃣ DimAudio
CREATE TABLE DimAudio (
    AudioID INT IDENTITY(1,1) PRIMARY KEY,
    audio_amp_mean_ep_avg DECIMAL(18,6),
    audio_amp_std_ep_avg DECIMAL(18,6),
    audio_convo_duration_ep_avg DECIMAL(18,6),
    audio_covo_num_ep_avg DECIMAL(18,6),
    audio_voice_ep_avg DECIMAL(18,6)
);

-- 5️⃣ DimLocationUnlock
CREATE TABLE DimLocationUnlock (
    LocationUnlockID INT IDENTITY(1,1) PRIMARY KEY,
    loc_home_unlock_duration_avg DECIMAL(18,6),
    loc_home_unlock_num INT,
    loc_home_dur DECIMAL(18,6),
    loc_leisure_dur DECIMAL(18,6),
    loc_social_dur DECIMAL(18,6),
    loc_study_dur DECIMAL(18,6),
    loc_workout_dur DECIMAL(18,6),
    loc_worship_dur DECIMAL(18,6),
    unlock_duration_ep_avg DECIMAL(18,6),
    unlock_num_ep_avg DECIMAL(18,6)
);

-- 7️⃣ DimTime
CREATE TABLE DimTime (
    TimeID INT IDENTITY(1,1) PRIMARY KEY,
    [Date] DATE,
    [Day] AS DAY([Date]),
    [Month] AS MONTH([Date]),
    [Year] AS YEAR([Date])
);


CREATE TABLE FactBehavior (
    FactID INT IDENTITY(1,1) PRIMARY KEY,     
    UID VARCHAR(10) NOT NULL,                
    TimeID INT NOT NULL,                     
    MentalID INT NOT NULL,                    
    total_phq4_score INT,                
    total_sse3_score INT,                   
    LocationUnlockID INT,                    
    SleepMotionID INT,                   
    AudioID INT,                              
	total_steps INT,
);
ALTER TABLE FactBehavior
ADD
    FOREIGN KEY (UID) REFERENCES DimUser(UID),
    FOREIGN KEY (TimeID) REFERENCES DimTime(TimeID),
    FOREIGN KEY (MentalID) REFERENCES DimMental(MentalID),
    FOREIGN KEY (LocationUnlockID) REFERENCES DimLocationUnlock(LocationUnlockID),
    FOREIGN KEY (SleepMotionID) REFERENCES DimSleepMotion(SleepMotionID),
    FOREIGN KEY (AudioID) REFERENCES DimAudio(AudioID);



ALTER TABLE [dbo].[DimSleepMotion]
ALTER COLUMN sleep_duration DECIMAL(10,2);

ALTER TABLE [dbo].[stg_sensing]
ALTER COLUMN sleep_duration DECIMAL(10,2);









