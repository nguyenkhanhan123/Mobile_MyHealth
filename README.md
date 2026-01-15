# Ứng dụng Quản lý Dinh dưỡng tích hợp Chatbot AI (MyHealth)

## Giới thiệu
**MyHealth** là hệ thống quản lý dinh dưỡng thông minh giúp người dùng trở thành "chuyên gia dinh dưỡng và huấn luyện viên cá nhân" của chính mình. Dự án tập trung vào việc cung cấp thực đơn cá nhân hóa, theo dõi quá trình tập luyện và giải đáp thắc mắc dinh dưỡng thông qua Chatbot AI.

### Mục tiêu chính
1.  **Cơ sở dữ liệu chuẩn Việt Nam**: Xây dựng kho dữ liệu món ăn, nguyên liệu phong phú, phù hợp với người Việt.
2.  **Cá nhân hóa**: Gợi ý thực đơn và lịch trình tập luyện dựa trên chỉ số cơ thể (BMI, BMR, TDEE) và mục tiêu riêng biệt.
3.  **Trợ lý AI thông minh**: Tích hợp Chatbot trả lời thắc mắc và tư vấn dinh dưỡng 24/7.

## Repository
- **Frontend (Flutter Mobile App)**:  
  (Repo hiện tại)

- **Backend & AI Services**:  
  https://github.com/trunglap923/BE_MyHeath

## Công nghệ sử dụng
Dự án được xây dựng trên nền tảng công nghệ hiện đại, kết hợp giữa Mobile App và Backend Microservices tích hợp AI.

### Mobile App
*   **Flutter & Dart**: Phát triển ứng dụng đa nền tảng (Android/iOS) với hiệu năng cao và giao diện mượt mà.
*   **Dio**: Thư viện HTTP client mạnh mẽ cho giao tiếp với Server.

### Backend & AI
*   **Python**: Ngôn ngữ chính cho Backend và xử lý dữ liệu AI.
*   **FastAPI**: Framework hiệu năng cao để xây dựng API.
*   **PostgreSQL**: Hệ quản trị cơ sở dữ liệu quan hệ mạnh mẽ.
*   **Firebase (FCM)**: Dịch vụ gửi thông báo và xác thực.
*   **ElasticSearch**: Tìm kiếm văn bản và Vector Search (cho món ăn tương đồng).
*   **LangChain & LangGraph**: Framework xây dựng ứng dụng LLM và luồng hội thoại.
*   **DeepSeek LLM**: Mô hình ngôn ngữ lớn được sử dụng cho Chatbot và sinh thực đơn.
*   **RAG (Retrieval-Augmented Generation)**: Kỹ thuật kết hợp truy xuất dữ liệu để tăng độ chính xác cho AI.

## Kiến trúc Hệ thống
Hệ thống Backend được thiết kế theo kiến trúc **Microservices** để đảm bảo khả năng mở rộng và hiệu năng:

1.  **Core Service (Port 8000)**:
    *   Quản lý Người dùng (User Profile, Auth).
    *   Quản lý Dữ liệu Món ăn/Nguyên liệu (Food CRUD).
    *   Theo dõi Nhật ký (Tracking): Bữa ăn, Lượng nước, Tập luyện.
    *   Thông báo (Notifications).

2.  **Chatbot & Agent Service (Port 8001)**:
    *   **Chatbot AI**: Tư vấn dinh dưỡng sử dụng RAG.
    *   **Meal Planner**: Agent tự động gợi ý thực đơn dựa trên thuật toán tối ưu (SLSQP) và AI.

3.  **Search Service (Port 8002)**:
    *   **Vector Search**: Tìm kiếm món ăn tương đồng, thay thế món ăn.
    *   **Knowledge Base**: Quản lý Embedding và Indexing trong ElasticSearch.

## Tính năng & Demo
*   **Theo dõi dinh dưỡng**: Theo dõi thông tin các chất dinh dưỡng trong cơ thể.

<p align="center">
  <img src="image/health.png" height="400" />
</p>

---
*   **Nhật ký các món đã ăn**: Theo dõi các món ăn đã ăn vào trong ngày.

<p align="center">
  <img src="image/meal_1.png" height="400" />
</p>

---
*   **Gợi ý Thực đơn**: Lên thực đơn hàng ngày phù hợp với mục tiêu cân nặng.

<p align="center">
  <img src="image/meal_plan.png" height="400" />
</p>

---
*   **Chatbot AI**: Hỏi đáp với chatbot.

<p align="center">
  <img src="image/chatbot.png" height="400" />
</p>


---
* **Nhóm thực hiện**: Nguyễn Khánh An - Vũ Trung Lập
* **Giảng viên hướng dẫn**: PGS. TS. Nguyễn Trọng Khánh
