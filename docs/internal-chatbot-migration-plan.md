# Internal Chatbot Migration Plan (MVP → Phase 4)

## 1) MVP (Phase 1): 실행 가능화

### 목표
- `.env` 기준으로 compose 서비스 기동
- backend `/health` 응답
- Postgres 연결 일관성 확보

### 적용 내용
- `backend/app/core/database.py`: SQLite 메모리 제거, `DATABASE_URL` 기반 연결
- `.env.example` / `docker-compose.yml` / `install.sh`: DB, Chroma, backend 포트 통일
- `frontend/widget/govbot-widget.js`: 요청마다 랜덤 user id 생성 대신 localStorage 고정 ID 사용

### Windows PowerShell 기준
```powershell
Copy-Item .env.example .env
docker compose up -d
docker compose ps
docker compose logs -f backend
Invoke-RestMethod http://localhost:8000/health
Start-Process http://localhost:8000/docs
```

## 2) 용어 전환 (Phase 2)

### 권장 리네이밍
- `complaints` → `inquiries`
- `petition` → `inquiry`
- `officer_contact` → `department_contact`
- `sanctions` → `access_control` 또는 `rate_limits`

### 엔티티(1차)
- organizations
- departments
- faq_items
- documents
- document_chunks
- error_code_entries
- inquiry_logs
- department_contacts
- answer_templates

## 3) 검색 흐름 (Phase 3)

1. 질문 정규화
2. 분류(`question_type`, `department`)
3. 부서 FAQ 검색
4. 부서 문서 RAG
5. 공통 문서 RAG
6. 답변 생성
7. Low confidence 시 담당자 안내
8. inquiry log 저장

## 4) 관리자 확장 (Phase 4)

- 담당자/연락망 CRUD
- FAQ 승인/공개 워크플로우
- 문서 버전/승인/공개범위 관리
- 부서별 문의량/미해결/Low-confidence 대시보드
