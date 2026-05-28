CREATE DATABASE MentalHealthDW;
GO
USE MentalHealthDW;
GO

-- 1. Demographics
CREATE TABLE stg_demographics (
    uid VARCHAR(10),
    gender VARCHAR(10)
);

-- 2. General EMA
CREATE TABLE stg_general_ema (
    uid VARCHAR(10),
    day DATE,
    phq4_1 INT,
    phq4_2 INT,
    phq4_3 INT,
    phq4_4 INT,
	phq4_score INT,
    stress INT,
    social_level INT,
    sse3_1 INT,
    sse3_2 INT,
    sse3_3 INT,
    sse3_4 INT,
	sse3_score INT
);

-- 3. Sensing
CREATE TABLE stg_sensing (
    uid VARCHAR(10),
    day DATE,

    -- 💤 Sleep
    sleep_duration FLOAT,               -- tổng thời lượng ngủ trong ngày (giờ)
    sleep_start FLOAT,                  -- thời gian bắt đầu giấc ngủ (mã hóa)
    sleep_end FLOAT,                    -- thời gian kết thúc giấc ngủ (mã hóa)
    sleep_start_time TIME,             -- thời gian bắt đầu giấc ngủ (giờ)
    sleep_end_time TIME,               -- thời gian kết thúc giấc ngủ (giờ)

    -- 🚗 Activity
    act_in_vehicle_ep_avg FLOAT,        -- thời lượng trung bình ở trong xe (giờ)
    act_on_foot_ep_avg FLOAT,           -- thời lượng trung bình đi bộ (giờ)
    act_still_ep_avg FLOAT,             -- thời lượng trung bình đứng yên (giờ)

    -- 🔊 Audio
    audio_amp_mean_ep_avg FLOAT,        -- mức âm lượng trung bình (mean amplitude)
    audio_amp_std_ep_avg FLOAT,         -- độ lệch chuẩn âm lượng (độ biến động)
    audio_convo_duration_ep_avg FLOAT,  -- tổng thời lượng trung bình hội thoại (giờ)
    audio_covo_num_ep_avg FLOAT,        -- số lần trung bình xuất hiện hội thoại
    audio_voice_ep_avg FLOAT,           -- tỷ lệ thời gian có giọng nói (so với tổng thời gian)

    -- 📍 Location-based durations
    loc_dist_ep_avg FLOAT,              -- quãng đường trung bình di chuyển (mét)
    loc_home_dur FLOAT,                 -- thời lượng ở nhà (giờ)
    loc_leisure_dur FLOAT,              -- thời lượng ở nơi giải trí (giờ)
    loc_social_dur FLOAT,               -- thời lượng ở nơi xã hội (giờ)
    loc_study_dur FLOAT,                -- thời lượng ở nơi học tập (giờ)
    loc_workout_dur FLOAT,              -- thời lượng ở nơi tập thể dục (giờ)
    loc_worship_dur FLOAT,              -- thời lượng ở nơi tôn giáo (giờ)

    -- 🔓 Unlock / phone usage
	unlock_duration_ep_avg FLOAT,       -- thời lượng trung bình màn hình được mở (giờ)
    unlock_num_ep_avg FLOAT,            -- số lần mở khóa trung bình trong ngày
    loc_home_unlock_duration_avg FLOAT, -- thời lượng trung bình mở khóa ở nhà (phút)
    loc_home_unlock_num INT,            -- số lần trung bình mở khóa ở nhà

);


-- 4. Step
CREATE TABLE stg_step (
    uid VARCHAR(10),
    day DATE,
    steps_total INT
);

