# PHÂN TÍCH HÀNH VI – SỨC KHỎE TINH THẦN SINH VIÊN

## Tổng quan dự án

Trong những năm gần đây, sức khỏe tinh thần đang trở thành một trong những vấn đề được quan tâm hàng đầu tại các trường đại học trên thế giới. Tuy nhiên, phần lớn các tổ chức giáo dục vẫn chưa có hệ thống dữ liệu tập trung để theo dõi, phân tích và hỗ trợ đưa ra quyết định liên quan đến sức khỏe tâm lý của sinh viên.

## Bài toán

### Thực trạng

Các tổ chức giáo dục hiện nay gặp nhiều khó khăn trong việc:

- Dữ liệu nằm rải rác ở nhiều nguồn khác nhau.
- Không có hệ thống theo dõi sức khỏe tinh thần tập trung.
- Khó phát hiện sớm các dấu hiệu căng thẳng hoặc trầm cảm.
- Khó đánh giá tác động của các hành vi hằng ngày đến trạng thái tâm lý.
- Việc phân tích dữ liệu chủ yếu thực hiện thủ công và tốn nhiều thời gian.

### Câu hỏi

Dự án được xây dựng nhằm trả lời các câu hỏi sau:

#### 1. Giấc ngủ ảnh hưởng như thế nào đến mức độ căng thẳng?

#### 2. Hoạt động thể chất có giúp cải thiện sức khỏe tinh thần hay không?

#### 3. Mức độ giao tiếp xã hội ảnh hưởng thế nào đến cảm xúc của sinh viên?

#### 4. Việc sử dụng điện thoại quá nhiều có liên quan đến mức độ lo âu hay không?

#### 5. Nhóm sinh viên nào có nguy cơ gặp vấn đề về sức khỏe tinh thần cao nhất?


## Nguồn dữ liệu

Dự án sử dụng bộ dữ liệu **College Experience Study Dataset** được công bố trên Kaggle, thu thập dữ liệu hành vi và sức khỏe tinh thần của sinh viên trong giai đoạn 2017–2022.

Bộ dữ liệu được phát triển bởi nhóm nghiên cứu của **Dartmouth College** dưới sự dẫn dắt của **Andrew T. Campbell**, bao gồm dữ liệu về giấc ngủ, hoạt động thể chất, sử dụng điện thoại, tương tác xã hội và các khảo sát đánh giá sức khỏe tinh thần.

Nguồn: https://www.kaggle.com/datasets/subigyanepal/college-experience-dataset

### 1. Thông tin cá nhân (Demographics)

- UID
- Giới tính

### 2. Khảo sát tâm lý (General EMA)

- PHQ-4 (Đánh giá lo âu và trầm cảm)
- Stress
- Social Level
- SSE3 (Mức độ tự tôn bản thân)

### 3. Dữ liệu cảm biến hành vi (Sensing)

- Giấc ngủ
- Di chuyển
- Hoạt động thể chất
- Âm thanh
- Hội thoại
- Sử dụng điện thoại

### 4. Dữ liệu vận động (Steps)

- Tổng số bước đi mỗi ngày

## Kiến trúc hệ thống

```text
PROJECT/
├─ code/                                   # Code xử lý dữ liệu + script SQL
│  ├─ stg.sql                               # Script tạo/đổ dữ liệu vào STAGING (raw → staging)
│  ├─ dim.sql                               # Script tạo DIMENSION + mapping dim (DimUser/DimTime/…)
│  └─ filexulydulieu.ipynb                  # Notebook xử lý dữ liệu (clean/transform/feature engineering)
│
├─ main data/                               # Dữ liệu đầu vào + tài liệu giải thích dữ liệu
│  ├─ Demographics/                         # Nhóm dữ liệu nhân khẩu học (UID, gender, ...)
│  ├─ EMA/                                  # Nhóm khảo sát tâm lý (PHQ4, Stress, Social, SSE3, ...)
│  ├─ Sensing/                              # Nhóm dữ liệu cảm biến (sleep, audio, unlock, location, ...)
│  ├─ giải thích data.pdf                   # Tài liệu mô tả dataset / định nghĩa biến (PDF)
│  └─ giải thích.docx                       # Tài liệu mô tả dataset / ghi chú làm dữ liệu (Word)
│
├─ reports/                                 # Dashboard + báo cáo cuối
│  ├─ FINAL_WAREHOUSE_REPORT.pbix            # Power BI Dashboard/Report (KPI + các trang phân tích)
│  └─ Phân tích hành vi và sức khỏe tinh thần.docx  # Báo cáo phân tích + insight + đề xuất
│
├─ SSAS_mentalhealth/                       # Project SSAS (OLAP Cube)
│  ├─ .vs/                                  # File cache cấu hình VS (khuyến nghị đưa vào .gitignore)
│  ├─ mentalhealth/                         # Source project SSAS (cube, dimensions, measures)
│  └─ mentalhealth.sln                      # Solution SSAS để mở trong Visual Studio
│
├─ SSIS/                                    # Project SSIS (ETL Pipeline)
│  ├─ .vs/                                  # File cache cấu hình VS (khuyến nghị đưa vào .gitignore)
│  ├─ DATA FLOW/                            # Nơi chứa package/flow ETL (Extract → Transform → Load)
│  └─ DATA FLOW.sln                         # Solution SSIS để mở trong Visual Studio
│
└─ README.md                                # Tổng quan dự án + kiến trúc + quy trình ETL + star schema + KPI/insight
```

## Quy trình ETL

### Extract

Thu thập dữ liệu từ:

- demographics.csv
- general_ema.csv
- sensing.csv
- steps.csv

và đưa vào vùng Staging.

---

### Transform

#### Làm sạch dữ liệu

- Loại bỏ dữ liệu trùng lặp
- Xử lý dữ liệu thiếu
- Chuẩn hóa định dạng dữ liệu
- Đồng bộ mã người dùng (UID)

#### Feature Engineering

Bổ sung các thuộc tính phục vụ phân tích:

#### Chuyển đổi thời gian ngủ

Từ:

```text
sleep_start
sleep_end
```

Thành:

```text
sleep_start_time
sleep_end_time
```

Giúp người dùng dễ dàng đọc và phân tích.

#### Tổng hợp dữ liệu hành vi

Tính giá trị trung bình theo các khung giờ:

```text
0h - 9h
9h - 18h
18h - 24h
```

Ví dụ:

- act_on_foot_ep_avg
- loc_dist_ep_avg
- unlock_duration_ep_avg
- audio_convo_duration_ep_avg

---

### Load

Dữ liệu sau xử lý được nạp vào:

- Các bảng Dimension
- Bảng FactBehavior

trong hệ thống kho dữ liệu.

## Thiết kế kho dữ liệu

### Mô hình Star Schema

Hệ thống được thiết kế theo mô hình sao nhằm tối ưu cho:

- Truy vấn phân tích
- OLAP
- Dashboard
- Báo cáo quản trị

<p align="center">
  <img width="768" alt="Star Schema" src="https://github.com/user-attachments/assets/e7e56ccc-53d7-4e23-a337-552be54bd6f6">
</p>

<p align="center">
  <em>Hình 1. Mô hình Star Schema của hệ thống kho dữ liệu sức khỏe tinh thần.</em>
</p>


## Dashboard và KPI

### Dashboard Tổng quan

<p align="center">
  <img width="1410" height="792" alt="image" src="https://github.com/user-attachments/assets/95c033cc-9f7c-4ed4-b78f-c3bd0b1a9bed" />
</p>

<p align="center">
  <em>Hình 2. Dashboard Tổng quan </em>
</p>

#### KPI chính

- Mức độ Stress trung bình
- Điểm PHQ4 trung bình
- Điểm SSE3 trung bình
- Tổng số bước chân trung bình

### Dashboard Giấc ngủ và Cảm xúc

<p align="center">
  <img width="1419" height="795" alt="image" src="https://github.com/user-attachments/assets/97d4fdc8-70a0-4feb-980f-9b7f76d8f0f9" />
</p>

<p align="center">
  <em>Hình 3.Dashboard Giấc ngủ và Cảm xúc </em>
</p>

Theo dõi:

- Thời lượng ngủ
- Giờ ngủ trung bình
- Mối quan hệ giữa giấc ngủ và Stress

### Dashboard Hoạt động thể chất

<p align="center">
  <img width="1407" height="787" alt="image" src="https://github.com/user-attachments/assets/e68c863e-5179-45a6-bcba-b968eb1d96d6" />
</p>

<p align="center">
  <em>Hình 4.Dashboard Hoạt động thể chất </em>
</p>


Theo dõi:

- Số bước chân
- Mức độ vận động
- Tác động đến sức khỏe tinh thần

### Dashboard Tương tác xã hội và Hành vi sử dụng điện thoại
<p align="center">
  <img width="1410" height="784" alt="image" src="https://github.com/user-attachments/assets/03d734cc-3442-450f-b384-68e5bfc83259" />
</p>

<p align="center">
  <em>Hình 5.DashboardTương tác xã hội và Hành vi sử dụng điện thoại </em>
</p>

Theo dõi:

- Tần suất hội thoại
- Thời lượng giao tiếp
- Social Level
- Số lần mở khóa
- Thời lượng sử dụng điện thoại
- Tác động đến Stress và PHQ4


### Dashboard hành vi giao tiếp âm thanh  

<p align="center">
 <img width="1411" height="783" alt="image" src="https://github.com/user-attachments/assets/c4248c6d-6ed2-43bc-8633-33daacfca35e" />
</p>

<p align="center">
  <em>Hình 6.Dashboard Hành vi giao tiếp âm thanh  
 </em>
</p>



Theo dõi:
- Tổng số phút trò chuyện trung bình
- Tần suất hoặc số lượng cuộc hội thoại diễn ra trong một giờ
- Biên độ âm thanh


## Các phân tích thực hiện

### Insights & Recommendations

| Dashboard              | Business Question                                                                                                                                        | Main Insight                                                                                                                                                                 | Supporting Insights                                                                                                                                                                                                                                                              | Recommendation                                                                                                                                                                                                             |
| ---------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Overview**        | **Nhóm sinh viên nào có nguy cơ gặp vấn đề sức khỏe tinh thần cao nhất?**                                                                                | **Nhóm sinh viên có thời lượng ngủ thấp, mức độ giao tiếp xã hội thấp, thời gian ở nhà cao và tần suất sử dụng điện thoại lớn là nhóm có nguy cơ Stress và PHQ-4 cao nhất.** | • Stress cao thường đi kèm PHQ-4 cao và SSE-3 thấp.<br>• Các chỉ số tâm lý biến động theo thời gian và chịu ảnh hưởng bởi hành vi hằng ngày.<br>• Không có một yếu tố đơn lẻ quyết định sức khỏe tinh thần mà là sự kết hợp của nhiều hành vi.                                   | • Xây dựng hệ thống Early Warning System để nhận diện nhóm rủi ro cao.<br>• Theo dõi đồng thời Sleep Duration, Stress, PHQ-4 và Social Interaction.<br>• Ưu tiên hỗ trợ nhóm có nhiều tín hiệu rủi ro xuất hiện cùng lúc.  |
| **Sleep & Affect**  | **Giấc ngủ ảnh hưởng như thế nào đến mức độ căng thẳng?**                                                                                                | **Giấc ngủ là yếu tố có mối liên hệ mạnh nhất với Stress và trạng thái cảm xúc của sinh viên.**                                                                              | • Sinh viên ngủ ít có xu hướng ghi nhận Stress và PHQ-4 cao hơn.<br>• Thiếu ngủ thường xuất hiện trong các giai đoạn áp lực học tập cao.<br>• Nhóm ngủ đủ giấc duy trì trạng thái cảm xúc ổn định và mức tự tin tốt hơn.                                                         | • Triển khai các chương trình nâng cao nhận thức về giấc ngủ.<br>• Theo dõi các nhóm có thời lượng ngủ thấp kéo dài.<br>• Sử dụng Sleep Duration như một KPI trong hệ thống cảnh báo sớm.                                  |
| **Device Location** | **Hoạt động thể chất có giúp cải thiện sức khỏe tinh thần hay không?**<br>**Việc sử dụng điện thoại quá nhiều có liên quan đến mức độ lo âu hay không?** | **Lối sống ít vận động, dành nhiều thời gian ở nhà và sử dụng điện thoại thường xuyên có liên hệ với các dấu hiệu sức khỏe tinh thần kém tích cực hơn.**                     | • Home Time chiếm phần lớn thời gian của nhóm Stress cao.<br>• Social Time duy trì ở mức thấp ở nhiều nhóm sinh viên.<br>• Nhóm ở nhà nhiều thường ít vận động và ít giao tiếp hơn.<br>• Unlock Count có xu hướng tăng trong các giai đoạn Stress cao.                           | • Khuyến khích tham gia hoạt động ngoài trời và vận động thể chất.<br>• Theo dõi Home Time và Unlock Count như các chỉ báo hành vi.<br>• Thực hiện các chương trình Digital Well-being nhằm giảm phụ thuộc vào điện thoại. |
| **Audio Social**   | **Mức độ giao tiếp xã hội ảnh hưởng thế nào đến cảm xúc của sinh viên?**                                                                                 | **Mức độ giao tiếp thông qua hội thoại là một trong những chỉ báo quan trọng phản ánh sức khỏe tinh thần và mức độ kết nối xã hội của sinh viên.**                           | • Conversation Duration thấp thường đi kèm Stress và PHQ-4 cao hơn.<br>• Conversation Count phản ánh mức độ tương tác xã hội thực tế.<br>• Giao tiếp xã hội đóng vai trò như một yếu tố bảo vệ sức khỏe tinh thần.<br>• Sinh viên giao tiếp ít có nguy cơ cô lập xã hội cao hơn. | • Theo dõi các nhóm có mức độ giao tiếp giảm kéo dài.<br>• Tăng cường Peer Mentoring và Community Activities.<br>• Kết hợp Audio Metrics với Stress và Sleep để nhận diện nhóm rủi ro sớm.                                 |

### Project Conclusion
| Thành phần                    | Nội dung                                                                                                                                                 |
| ----------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Main Finding**              | Ngủ ít, giao tiếp xã hội thấp, thời gian ở nhà cao và sử dụng điện thoại thường xuyên là những hành vi có liên hệ mạnh nhất với nguy cơ Stress và lo âu. |
| **High-Risk Student Segment** | Sinh viên có Sleep Duration thấp, Conversation Duration thấp, Home Time cao và Unlock Count cao là nhóm có nguy cơ cao nhất.                             |
| **Implication**               | Các chỉ số hành vi có tiềm năng trở thành tín hiệu cảnh báo sớm cho các vấn đề sức khỏe tinh thần.                                                       |
| **Future Direction**          | Phát triển Early Warning System và các mô hình Machine Learning để hỗ trợ dự báo nguy cơ Stress trong tương lai.                                         |


## Hạn chế,Nguyên nhân
| Hạn chế                                                                           | Nguyên nhân                                                         | Hướng cải thiện                                                                                                                                         |
| --------------------------------------------------------------------------------- | ------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Dữ liệu chủ yếu phản ánh thói quen của nhóm sinh viên dành nhiều thời gian ở nhà. | Đối tượng nghiên cứu có lịch học tương đối cố định và ít di chuyển. | Mở rộng dữ liệu về hoạt động ngoài trời, địa điểm học tập và mức độ vận động để phản ánh đầy đủ hơn hành vi sinh hoạt.                                  |
| Social Time ở mức thấp nên khó phân biệt rõ các nhóm hành vi xã hội.              | Sinh viên chủ yếu tập trung cho học tập và hoạt động trong nhà.     | Thu thập thêm dữ liệu về sự kiện, câu lạc bộ và hoạt động ngoại khóa để đánh giá chính xác hơn mức độ tương tác xã hội.                                 |
| Chưa tích hợp dữ liệu học kỳ và lịch thi.                                         | Bộ dữ liệu không cung cấp thông tin Academic Calendar.              | Bổ sung Academic Calendar gồm học kỳ, lịch thi, thời gian nghỉ lễ và deadline môn học để giải thích các giai đoạn Stress tăng cao.                      |
| Dữ liệu âm thanh chưa được phân loại theo từng môi trường cụ thể.                 | Chỉ có thông tin mức độ âm thanh tổng quát.                         | Phân loại môi trường âm thanh như Library, Classroom, Café, Traffic hoặc Dormitory nhằm phân tích sâu hơn tác động của môi trường học tập và sinh hoạt. |
| Chưa đánh giá được chất lượng giấc ngủ.                                           | Dữ liệu chỉ ghi nhận thời lượng và thời điểm ngủ.                   | Thu thập thêm các chỉ số như Deep Sleep, REM Sleep, Sleep Interruptions và Sleep Efficiency để đánh giá toàn diện chất lượng giấc ngủ.                  |
| Chưa khai thác dữ liệu vận động chi tiết.                                         | Dữ liệu hiện tại chưa bao gồm đầy đủ các chỉ số hoạt động thể chất. | Bổ sung Steps, Distance, Exercise Duration và Calories Burned để đánh giá chính xác hơn mối liên hệ giữa vận động và sức khỏe tinh thần.                |
| Chưa hỗ trợ phân tích và giám sát theo thời gian thực.                            | Dữ liệu được thu thập và xử lý theo từng giai đoạn.                 | Tích hợp dữ liệu từ Wearable Devices, Smartphone Sensors và IoT Health Data để xây dựng hệ thống giám sát và cảnh báo sớm theo thời gian thực.          |



## Hướng phát triển tương lai

### 1. Xây dựng Early Warning System

Phát triển hệ thống cảnh báo sớm nhằm nhận diện sinh viên có nguy cơ gặp vấn đề về sức khỏe tinh thần dựa trên các chỉ số hành vi như:

- Sleep Duration
- Conversation Duration
- Home Time
- Unlock Count
- Stress
- PHQ-4

Hệ thống sẽ hỗ trợ nhà trường ưu tiên theo dõi và can thiệp sớm đối với các nhóm sinh viên có nguy cơ cao.

### 2. Xây dựng mô hình Machine Learning

Ứng dụng Machine Learning để:

- Dự đoán nguy cơ Stress.
- Dự báo mức độ lo âu và trầm cảm.
- Phân loại nhóm sinh viên theo mức độ rủi ro sức khỏe tinh thần.

### 3. Tích hợp Real-time Analytics

Kết nối dữ liệu cảm biến và dữ liệu hành vi theo thời gian thực nhằm hỗ trợ giám sát liên tục và phát hiện sớm các thay đổi bất thường trong trạng thái tâm lý.

### 4. Triển khai Dashboard trực tuyến

Phát triển nền tảng Dashboard Web hoặc Cloud BI giúp nhà trường và các đơn vị hỗ trợ sinh viên dễ dàng theo dõi tình trạng sức khỏe tinh thần theo thời gian thực.

### 5. Hỗ trợ ra quyết định dựa trên dữ liệu

Mở rộng hệ thống thành nền tảng Decision Support System (DSS), giúp các nhà quản lý xây dựng chương trình hỗ trợ, can thiệp và nâng cao sức khỏe tinh thần dựa trên dữ liệu thay vì cảm tính.

---

