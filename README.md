# PHÂN TÍCH HÀNH VI – SỨC KHỎE TINH THẦN SINH VIÊN

## Tổng quan dự án

Trong những năm gần đây, sức khỏe tinh thần đang trở thành một trong những vấn đề được quan tâm hàng đầu tại các trường đại học trên thế giới. Tuy nhiên, phần lớn các tổ chức giáo dục vẫn chưa có hệ thống dữ liệu tập trung để theo dõi, phân tích và hỗ trợ đưa ra quyết định liên quan đến sức khỏe tâm lý của sinh viên.

Dự án này xây dựng một hệ thống **Data Warehouse & Business Intelligence** nhằm thu thập, xử lý, lưu trữ và phân tích dữ liệu hành vi của sinh viên để hỗ trợ đánh giá tình trạng sức khỏe tinh thần dựa trên các yếu tố như:

- Giấc ngủ
- Hoạt động thể chất
- Mức độ căng thẳng
- Mức độ tự tin
- Tương tác xã hội
- Hành vi sử dụng điện thoại
- Môi trường âm thanh xung quanh

Hệ thống được phát triển theo mô hình Business Intelligence hoàn chỉnh, bao gồm:

- Data Warehouse
- ETL Pipeline
- OLAP Cube
- Dashboard & Reporting
- Decision Support Analytics

## Bài toán kinh doanh

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

## Giá trị dự án mang lại

- Hệ thống hỗ trợ:

- Phát hiện sớm sinh viên có nguy cơ gặp vấn đề tâm lý

- Theo dõi xu hướng sức khỏe tinh thần theo thời gian

- Hỗ trợ nhà trường đưa ra các chương trình can thiệp phù hợp

- Hỗ trợ ra quyết định dựa trên dữ liệu thay vì cảm tính

- Tạo nền tảng cho các mô hình dự báo sức khỏe tinh thần trong tương lai

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

---

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

## Công nghệ sử dụng

| Nhóm            | Công nghệ          |
| --------------- | ------------------ |
| Database        | SQL Server         |
| ETL             | SSIS               |
| OLAP            | SSAS               |
| BI              | Power BI           |
| Programming     | Python             |
| Data Processing | pandas, Numpy      |
| Reporting       | Power BI           |
| Development     | Visual Studio 2022 |

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

### Phân tích mô tả (Descriptive Analytics)

Mô tả hiện trạng sức khỏe tinh thần của sinh viên.

### Phân tích chẩn đoán (Diagnostic Analytics)

Tìm hiểu nguyên nhân dẫn đến:

- Stress cao
- Lo âu
- Mất cân bằng cảm xúc

### Phân tích gợi ý (Prescriptive Analytics)

Đề xuất:

- Cải thiện chất lượng giấc ngủ
- Tăng cường vận động
- Khuyến khích giao tiếp xã hội

## Insight nổi bật

### Insight 1

Sinh viên có thời lượng ngủ thấp thường có mức độ Stress và PHQ4 cao hơn.

### Insight 2

Số bước chân cao hơn thường đi kèm với trạng thái tinh thần tích cực hơn.

### Insight 3

Sinh viên có mức độ giao tiếp xã hội cao thường có điểm Stress thấp hơn.

### Insight 4

Việc sử dụng điện thoại quá thường xuyên có xu hướng liên quan đến mức độ căng thẳng cao hơn.

## Đề xuất cho Stakeholders

### Đối với nhà trường

- Xây dựng chương trình theo dõi sức khỏe tinh thần định kỳ.
- Tăng cường các hoạt động thể chất và ngoại khóa.

### Đối với bộ phận hỗ trợ sinh viên

- Thiết lập hệ thống cảnh báo sớm đối với sinh viên có nguy cơ cao.
- Tập trung hỗ trợ các nhóm có Stress hoặc PHQ4 cao.

### Đối với các nhà nghiên cứu

- Sử dụng nền tảng làm cơ sở cho các mô hình dự báo sức khỏe tinh thần bằng Machine Learning.

## Kỹ năng Data Analyst thể hiện trong dự án

Dự án thể hiện đầy đủ các năng lực cốt lõi của một Data Analyst:

### SQL

- Data Modeling
- Data Warehouse
- OLAP Analysis
- Query Optimization

### Data Engineering

- ETL Pipeline
- Data Cleaning
- Data Transformation

### Business Intelligence

- KPI Design
- Dashboard Development
- Reporting Automation

### Analytics

- Descriptive Analytics
- Diagnostic Analytics
- Prescriptive Analytics

### Business Thinking

- Chuyển đổi bài toán nghiệp vụ thành bài toán dữ liệu
- Phân tích nguyên nhân gốc rễ
- Đưa ra khuyến nghị dựa trên dữ liệu
- Hỗ trợ ra quyết định cho Stakeholders

## Hướng phát triển tương lai

- Xây dựng mô hình Machine Learning dự đoán nguy cơ Stress.
- Dự báo mức độ lo âu và trầm cảm.
- Tích hợp dữ liệu thời gian thực (Real-time Analytics).
- Triển khai Dashboard trực tuyến cho nhà trường.

---

