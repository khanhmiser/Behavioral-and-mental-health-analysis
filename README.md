# 🧠 HỆ THỐNG KHO DỮ LIỆU VÀ PHÂN TÍCH HÀNH VI – SỨC KHỎE TINH THẦN SINH VIÊN

## 📌 Tổng quan dự án

Trong những năm gần đây, sức khỏe tinh thần đang trở thành một trong những vấn đề được quan tâm hàng đầu tại các trường đại học trên thế giới. Tuy nh[...]

Dự án này xây dựng một hệ thống **Data Warehouse & Business Intelligence** nhằm thu thập, xử lý, lưu trữ và phân tích dữ liệu hành vi của sinh viên để hỗ trợ �[...]

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

---

# 🎯 Bài toán kinh doanh

## Thực trạng

Các tổ chức giáo dục hiện nay gặp nhiều khó khăn trong việc:

- Dữ liệu nằm rải rác ở nhiều nguồn khác nhau.
- Không có hệ thống theo dõi sức khỏe tinh thần tập trung.
- Khó phát hiện sớm các dấu hiệu căng thẳng hoặc trầm cảm.
- Khó đánh giá tác động của các hành vi hằng ngày đến trạng thái tâm lý.
- Việc phân tích dữ liệu chủ yếu thực hiện thủ công và tốn nhiều thời gian.

## Câu hỏi kinh doanh

Dự án được xây dựng nhằm trả lời các câu hỏi sau:

### 1. Giấc ngủ ảnh hưởng như thế nào đến mức độ căng thẳng?

### 2. Hoạt động thể chất có giúp cải thiện sức khỏe tinh thần hay không?

### 3. Mức độ giao tiếp xã hội ảnh hưởng thế nào đến cảm xúc của sinh viên?

### 4. Việc sử dụng điện thoại quá nhiều có liên quan đến mức độ lo âu hay không?

### 5. Nhóm sinh viên nào có nguy cơ gặp vấn đề về sức khỏe tinh thần cao nhất?

---

# 💼 Giá trị kinh doanh mang lại

Hệ thống hỗ trợ:

✅ Phát hiện sớm sinh viên có nguy cơ gặp vấn đề tâm lý

✅ Theo dõi xu hướng sức khỏe tinh thần theo thời gian

✅ Hỗ trợ nhà trường đưa ra các chương trình can thiệp phù hợp

✅ Hỗ trợ ra quyết định dựa trên dữ liệu thay vì cảm tính

✅ Tạo nền tảng cho các mô hình dự báo sức khỏe tinh thần trong tương lai

---

# 📊 Nguồn dữ liệu

## Dataset

Bộ dữ liệu được sử dụng từ nghiên cứu:

**Five-Year Mobile Sensing Study**

Thực hiện bởi:

- Dartmouth College
- Andrew T. Campbell Research Team

## Loại dữ liệu

Dữ liệu đa nguồn (Multi-Modal Dataset) kéo dài trong 5 năm, bao gồm:

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

---

# 🏗️ Kiến trúc hệ thống (Cấu trúc thư mục Repository)

```text
Behavioral-and-mental-health-analysis/
├── README.md
├── SSIS/
│   ├── DATA FLOW.sln
│   ├── DATA FLOW/
│   │   ├── DATA FLOW.database
│   │   ├── DATA FLOW.dtproj
│   │   ├── DATA FLOW.dtproj.user
│   │   ├── Project.params
│   │   ├── loaddim.dtsx
│   │   ├── loadfact.dtsx
│   │   ├── loadstg.dtsx
│   │   ├── bin/
│   │   └── obj/
│   └── .vs/
├── SSAS/
│   └── mentalhealth/
│       ├── mentalhealth.sln
│       ├── mentalhealth/
│       │   ├── Dim Audio.dim
│       │   ├── Dim Location Unlock.dim
│       │   ├── Dim Mental.dim
│       │   ├── Dim Sleep Motion.dim
│       │   ├── Dim Time.dim
│       │   ├── Dim User.dim
│       │   ├── Mental Health DW.cube
│       │   ├── Mental Health DW.ds
│       │   ├── Mental Health DW.dsv
│       │   ├── Mental Health DW.partitions
│       │   ├── mentalhealth.database
│       │   ├── mentalhealth.dwproj
│       │   ├── mentalhealth.dwproj.user
│       │   ├── bin/
│       │   └── obj/
│       └── .vs/
├── code/
│   ├── dim.sql
│   ├── stg.sql
│   └── filexulydulieu.ipynb
├── main data/
│   ├── Demographics/
│   │   └── demographics.csv
│   ├── EMA/
│   ├── Sensing/
│   ├── giải thích data.pdf
│   └── giải thích.docx
└── reports/
    ├── FINAL_WAREHOUSE_REPORT.pbix
    └── Phân tích hành vi và sức khoẻ tinh thần.docx
```

## # Giải thích nhanh

- `SSIS/`: Dự án ETL (Extract–Transform–Load) bằng SSIS.
- `SSAS/`: Dự án OLAP/Cube (SSAS) để phân tích đa chiều.
- `code/`: Script SQL (tạo staging/dimension) và notebook Python xử lý dữ liệu.
- `main data/`: Dữ liệu đầu vào (CSV) + tài liệu mô tả/giải thích dataset.
- `reports/`: File báo cáo & dashboard.
  - `FINAL_WAREHOUSE_REPORT.pbix`: Dashboard Power BI kết nối kho dữ liệu.
  - `Phân tích hành vi và sức khoẻ tinh thần.docx`: Báo cáo phân tích/viết tay (nội dung, insight, kết luận).

---

# 🔄 Quy trình ETL

## Extract

Thu thập dữ liệu từ:

- demographics.csv
- general_ema.csv
- sensing.csv
- steps.csv

và đưa vào vùng Staging.

---

## Transform

### Làm sạch dữ liệu

- Loại bỏ dữ liệu trùng lặp
- Xử lý dữ liệu thiếu
- Chuẩn hóa định dạng dữ liệu
- Đồng bộ mã người dùng (UID)

### Feature Engineering

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

### Tổng hợp dữ liệu hành vi

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

## Load

Dữ liệu sau xử lý được nạp vào:

- Các bảng Dimension
- Bảng FactBehavior

trong hệ thống kho dữ liệu.

---

# ⭐ Thiết kế kho dữ liệu

## Mô hình Star Schema

Hệ thống được thiết kế theo mô hình sao nhằm tối ưu cho:

- Truy vấn phân tích
- OLAP
- Dashboard
- Báo cáo quản trị

---

## Fact Table

### FactBehavior

Lưu trữ các chỉ số phân tích chính:

| Chỉ số            |
| ----------------- |
| Tổng điểm PHQ4    |
| Tổng điểm SSE3    |
| Tổng số bước chân |
| Mức độ căng thẳng |

---

## Dimension Tables

### DimUser

Thông tin người dùng

- UID
- Giới tính

---

### DimTime

Thông tin thời gian

- Ngày
- Tháng
- Năm

---

### DimMental

Thông tin sức khỏe tinh thần

- PHQ4
- Stress
- Social Level
- SSE3

---

### DimSleepMotion

Thông tin giấc ngủ và vận động

- Thời lượng ngủ
- Thời gian bắt đầu ngủ
- Thời gian thức dậy
- Mức độ vận động

---

### DimAudio

Thông tin âm thanh và giao tiếp

- Tần suất hội thoại
- Thời lượng hội thoại
- Cường độ âm thanh

---

### DimLocationUnlock

Thông tin sử dụng điện thoại và vị trí

- Số lần mở khóa
- Thời lượng sử dụng
- Thời gian ở nhà
- Thời gian học tập
- Thời gian tập luyện

---

# ⚙️ Công nghệ sử dụng

| Nhóm            | Công nghệ          |
| --------------- | ------------------ |
| Database        | SQL Server         |
| ETL             | SSIS               |
| OLAP            | SSAS               |
| BI              | Power BI           |
| Programming     | Python             |
| Data Processing | Pandas             |
| Reporting       | Power BI           |
| Development     | Visual Studio 2022 |

---

# 📈 Dashboard và KPI

## Dashboard Tổng quan

### KPI chính

- Mức độ Stress trung bình
- Điểm PHQ4 trung bình
- Điểm SSE3 trung bình
- Tổng số bước chân trung bình

---

## Dashboard Giấc ngủ và Cảm xúc

Theo dõi:

- Thời lượng ngủ
- Giờ ngủ trung bình
- Mối quan hệ giữa giấc ngủ và Stress

---

## Dashboard Hoạt động thể chất

Theo dõi:

- Số bước chân
- Mức độ vận động
- Tác động đến sức khỏe tinh thần

---

## Dashboard Tương tác xã hội

Theo dõi:

- Tần suất hội thoại
- Thời lượng giao tiếp
- Social Level

---

## Dashboard Hành vi sử dụng điện thoại

Theo dõi:

- Số lần mở khóa
- Thời lượng sử dụng điện thoại
- Tác động đến Stress và PHQ4

---

# 🔍 Các phân tích thực hiện

## Phân tích mô tả (Descriptive Analytics)

Mô tả hiện trạng sức khỏe tinh thần của sinh viên.

---

## Phân tích chẩn đoán (Diagnostic Analytics)

Tìm hiểu nguyên nhân dẫn đến:

- Stress cao
- Lo âu
- Mất cân bằng cảm xúc

---

## Phân tích gợi ý (Prescriptive Analytics)

Đề xuất:

- Cải thiện chất lượng giấc ngủ
- Tăng cường vận động
- Khuyến khích giao tiếp xã hội

---

# 📌 Insight nổi bật

### Insight 1

Sinh viên có thời lượng ngủ thấp thường có mức độ Stress và PHQ4 cao hơn.

### Insight 2

Số bước chân cao hơn thường đi kèm với trạng thái tinh thần tích cực hơn.

### Insight 3

Sinh viên có mức độ giao tiếp xã hội cao thường có điểm Stress thấp hơn.

### Insight 4

Việc sử dụng điện thoại quá thường xuyên có xu hướng liên quan đến mức độ căng thẳng cao hơn.

---

# 🚀 Đề xuất cho Stakeholders

### Đối với nhà trường

- Xây dựng chương trình theo dõi sức khỏe tinh thần định kỳ.
- Tăng cường các hoạt động thể chất và ngoại khóa.

### Đối với bộ phận hỗ trợ sinh viên

- Thiết lập hệ thống cảnh báo sớm đối với sinh viên có nguy cơ cao.
- Tập trung hỗ trợ các nhóm có Stress hoặc PHQ4 cao.

### Đối với các nhà nghiên cứu

- Sử dụng nền tảng làm cơ sở cho các mô hình dự báo sức khỏe tinh thần bằng Machine Learning.

---

# 📚 Kỹ năng Data Analyst thể hiện trong dự án

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

---

# 🔮 Hướng phát triển tương lai

- Xây dựng mô hình Machine Learning dự đoán nguy cơ Stress.
- Dự báo mức độ lo âu và trầm cảm.
- Tích hợp dữ liệu thời gian thực (Real-time Analytics).
- Triển khai Dashboard trực tuyến cho nhà trường.

---

# 👨‍💻 Tác giả

**Hoàng Quốc Khánh**

Data Analyst | Business Intelligence | SQL | Power BI | Python | Data Warehouse

📧 Email: Your Email

🔗 LinkedIn: Your LinkedIn

🔗 GitHub: Your GitHub

---

> Đây là dự án End-to-End Business Intelligence thể hiện toàn bộ quy trình từ Data Engineering → Data Warehouse → OLAP → Dashboard → Business Insight, mô phỏng sát quy trì[...]
