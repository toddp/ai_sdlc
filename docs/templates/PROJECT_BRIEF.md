# Project Brief: <Project Name>

<!-- This document provides Claude Code with high-level context about your project -->

## Goal

**What are we building and why?**

Write a concise summary (2-4 sentences) that describes:
- The primary purpose of the system
- Who will use it and how
- The main value it provides

**Example:**
> Build a web application that extracts visible on-screen text from TikTok videos by processing uploaded lists of TikTok URLs. The system downloads videos using yt-dlp, uses Google Cloud Video Intelligence API to detect text, applies intelligent filtering to separate captions from static background text, and provides users with cleaned, exportable results.

---

## Constraints

**What technical and business constraints shape our decisions?**

- **Tech boundaries:** <Primary framework, language, database>
  - Example: Rails 8, Ruby 3.4+, PostgreSQL, Sidekiq

- **Infra available:** <Existing infrastructure and foundation>
  - Example: Jumpstart Pro Rails foundation, GCS bucket, AWS Lambda functions

- **External dependencies:** <Third-party tools, APIs, services>
  - Example: yt-dlp CLI for downloads, Stripe for payments, Twilio for SMS

- **Cost considerations:** <Budget constraints or cost optimization strategies>
  - Example: Video deduplication to minimize API calls, S3 lifecycle policies

- **Processing limits:** <Performance, scale, or resource limits>
  - Example: Async processing for long-running tasks, max 1000 records per batch

---

## Interfaces

### Web UI

**What are the main user-facing routes and pages?**

- **<Page Name>:** `GET/POST /path` - Description of what users do here
- **<Another Page>:** `GET /path/:id` - Another user action
- **<Action>:** `POST /path/:id/action` - Triggered action

**Example:**
- **Upload form:** `GET/POST /uploads` - Upload text file with URLs
- **Upload list:** `GET /uploads` - View all user uploads with status
- **Export:** `GET /uploads/:id/export` - Download CSV with results

### Data Models

**What are the core database tables and their relationships?**

```ruby
# ModelName: Description of what this represents
- field_name, field_name, status (enum values)
- relationship_field (JSONB/references)

# AnotherModel: Description
- fields, status, metadata

# JoinTable: Many-to-many relationship
- model_a_id, model_b_id, order_field
```

**Example:**
```ruby
# Upload: User's batch of URLs
- user_id, file_name, total_urls, processed_urls, status (pending/processing/completed/failed)

# Video: Deduplicated content
- url (unique), status, extracted_data, gcs_url, error_message

# UploadVideo: Join table
- upload_id, video_id, line_number (preserves order)
```

### Background Jobs

**What async jobs process work in the background?**

- **JobName:** Brief description of what it does
- **AnotherJob:** Another processing task

**Example:**
- **ProcessUploadJob:** Parse uploaded file, create Video records
- **ProcessVideoJob:** Download → upload to GCS → trigger extraction
- **CheckStatusJob:** Poll external API → process results
- **CleanupJob:** Remove temporary files after processing

### Services

**What service objects encapsulate business logic?**

- **ServiceName:** What this service does
- **AnotherService:** Another service responsibility

**Example:**
- **UrlParser:** Extract and validate URLs from uploaded files
- **Downloader:** Download content using external tool
- **TextExtractor:** Initiate external API text detection
- **TextProcessor:** Filter and clean extracted data
- **ExportService:** Generate export files with metadata

---

## Acceptance Criteria

**What must be true for each phase/milestone to be considered complete?**

Group acceptance criteria into logical phases or milestones.

### Phase 1: <Phase Name> (Status: ✅ Completed | 🔄 In Progress | ⏸️ Pending)
- [ ] AC1 — <Specific, testable criterion>
- [ ] AC2 — <Another criterion>
- [ ] AC3 — <One more criterion>

### Phase 2: <Phase Name> (Status)
- [ ] AC4 — <User-facing feature>
- [ ] AC5 — <System behavior>
- [ ] AC6 — <Quality requirement>

### Phase 3: <Phase Name> (Status)
- [ ] AC7 — <Refinement or optimization>
- [ ] AC8 — <Security requirement>
- [ ] AC9 — <Performance target>

**Note:** Each AC should be:
- **Specific:** Clear what needs to be built
- **Testable:** Can verify it works
- **User-focused:** Delivers value

---

## Risks & Non-goals

### Risks

**What could go wrong and how do we mitigate it?**

- **<Risk Name>:** Description of the risk.
  - **Mitigation:** How we'll prevent or handle it.

- **<Another Risk>:** Another potential issue.
  - **Mitigation:** Our mitigation strategy.

**Example:**
- **API costs:** External API charges per request.
  - **Mitigation:** Implement caching and deduplication across users.

- **Rate limiting:** Third-party service might block excessive requests.
  - **Mitigation:** Retry logic with exponential backoff, request throttling.

### Non-goals (Future Enhancements)

**What are we explicitly NOT building in this version?**

- <Feature we're deferring>
- <Platform or integration we're skipping>
- <Advanced capability for later>

**Example:**
- Real-time video streaming or playback
- Support for other platforms (Instagram, YouTube)
- User-customizable filtering rules
- Multi-language support (English only for MVP)

---

## Example Scenarios

**Walk through concrete examples of how the system should behave.**

### Scenario 1: <Happy Path Title>

**Input:** <What the user does>

**Output:**
- <Step 1 of what happens>
- <Step 2 of processing>
- <Step 3 final result>
- <What the user sees>

**Example:**
> ### Scenario 1: Happy Path - Single Upload
>
> **Input:** User uploads `urls.txt` with 10 valid URLs
>
> **Output:**
> - ProcessUploadJob creates 10 records
> - ProcessJob downloads each and processes
> - User sees "Completed 10/10" and can export results
> - Email notification sent with link

### Scenario 2: <Edge Case Title>

**Input:** <What triggers the edge case>

**Output:**
- <How the system handles it>
- <What the user experiences>

**Example:**
> ### Scenario 2: Duplicate URLs
>
> **Input:** User uploads file with 5 URLs, 2 already processed
>
> **Output:**
> - System reuses existing records for duplicates
> - Only 3 new items are processed
> - All 5 appear in user's results
> - Processing completes faster due to cache hit

### Scenario 3: <Error Case Title>

**Input:** <What causes the error>

**Output:**
- <How errors are handled>
- <User feedback provided>

**Example:**
> ### Scenario 3: Invalid Input
>
> **Input:** File contains mix of valid and invalid data
>
> **Output:**
> - Parser skips invalid lines, logs warnings with line numbers
> - Shows "Found 7 valid (3 invalid lines: 2, 5, 9)"
> - Processing continues with valid data only
> - User can review error details

### Scenario 4: <Performance/Scale Title>

**Input:** <Large-scale or performance test case>

**Output:**
- <How the system scales>
- <User experience at scale>

**Example:**
> ### Scenario 4: Large Batch Processing
>
> **Input:** User uploads 200 URLs
>
> **Output:**
> - Upload immediately shows "Processing 0/200"
> - Background jobs process in parallel
> - User can leave and return later
> - Email sent when complete
> - No timeout or degradation

---

## Additional Notes (Optional)

**Any other context Claude should know?**

- Architecture diagrams or external documentation links
- Special deployment considerations
- Team conventions or coding standards
- Performance benchmarks or SLAs
- Monitoring and alerting setup

---

## How to Use This Document

**For Claude Code:**
1. Read this brief at the start of each conversation
2. Cite sections when making design decisions
3. Align implementations with acceptance criteria
4. Check scenarios to understand expected behavior

**For Developers:**
1. Keep this document updated as requirements evolve
2. Add new phases/ACs as project progresses
3. Reference when writing SPECs and ADRs
4. Use scenarios for manual testing
