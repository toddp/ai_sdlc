# IMPLEMENTATION PLAN — <Project Name>

**Status:** ✅ <Milestone> Complete | 🚧 <Milestone> In Progress | 📋 <Milestone> Planned
**Last Updated:** <YYYY-MM-DD>
**Current Phase:** <Current Milestone Name>

---

## Vision & Scope

**Concise overview of what we're building (1-2 paragraphs)**

<Copy from PROJECT_BRIEF.md or write a summary here>

### Key Differentiators

**What makes this project unique or valuable?**

- **<Differentiator 1>:** Brief description
- **<Differentiator 2>:** Another unique aspect
- **<Differentiator 3>:** Another key feature

---

## Milestones

**Break the project into logical phases with clear acceptance criteria**

| ID | Title | Description | Status | Acceptance Criteria |
|----|-------|-------------|--------|---------------------|
| **M1** | **<Milestone Name>** | <What gets built in this phase> | ✅ **COMPLETE** / 🚧 **IN PROGRESS** / 📋 **PLANNED** | AC1-ACX |
| **M2** | **<Next Milestone>** | <Next phase description> | 🚧 **IN PROGRESS** | ACX-ACY |
| **M3** | **<Third Milestone>** | <Third phase description> | 📋 **PLANNED** | ACY-ACZ |

**Status Icons:**
- ✅ **COMPLETE** - All ACs met, code merged, deployed
- 🚧 **IN PROGRESS** - Active development, some ACs complete
- 📋 **PLANNED** - Not started, requirements defined

---

## Feature Catalog

### ✅ Completed (<Milestone Name>)

**Track what's been built and where the code lives**

| Feature | Files | Status | Notes |
|---------|-------|--------|-------|
| **<Feature Name>** | `app/path/to/file.rb`<br>`app/another/file.rb` | ✅ Complete | Brief implementation notes |
| **<Another Feature>** | `app/services/service.rb` | ✅ Complete | Any important details |

**Example:**
| Feature | Files | Status | Notes |
|---------|-------|--------|-------|
| **Data Models** | `app/models/upload.rb`<br>`app/models/video.rb` | ✅ Complete | Proper associations, validations, enum statuses |
| **URL Parsing** | `app/services/url_parser.rb` | ✅ Complete | Extracts URLs from files, preserves line numbers |

---

### 🚧 In Progress (<Current Milestone>)

**Track active work with estimates and dependencies**

| Feature | Priority | Owner | Estimated Effort | Target | Dependencies |
|---------|----------|-------|------------------|--------|--------------|
| **<Feature Name>** | 🔥 High | <Name/Team> | X-Y hours | ASAP / Week N | <Prerequisites> |
| **<Another Feature>** | 🔶 Medium | <Owner> | X-Y hours | Week N | <Dependencies> |
| **<Third Feature>** | 🟢 Low | <Owner> | X-Y hours | Week N+1 | <Prerequisites> |

**Priority Levels:**
- 🔥 **High** - Blocking other work, core functionality
- 🔶 **Medium** - Important but not blocking
- 🟢 **Low** - Nice-to-have, can defer

---

### 📋 Planned (<Future Milestone>)

**Features defined but not yet started**

| Feature | Priority | Estimated Effort | Target | Dependencies |
|---------|----------|------------------|--------|--------------|
| **<Future Feature>** | 🔶 Medium | X-Y hours | Week N | <What needs to be done first> |
| **<Another Feature>** | 🔥 High | X-Y hours | Week N | <Prerequisites> |

---

## Current Sprint: <Milestone Name>

### 🎯 Sprint Goals

**What are we trying to accomplish in this sprint?**

1. <Primary goal>
2. <Secondary goal>
3. <Tertiary goal>

---

### 📋 Detailed Tasks

**Break down features into actionable tasks**

#### Task 1: <Feature Name> (<AC Number>)

**Status:** ✅ Complete | 🚧 In Progress | 📋 Planned
**Estimate:** X-Y hours | **Actual:** <Actual hours if complete>

**Subtasks:**
- [ ] Subtask description
- [ ] Another subtask
- [ ] Final subtask

**Files to Create:**
- `app/path/to/new_file.rb`
- `app/views/path/template.html.erb`
- `test/path/test_file_test.rb`

**Files to Modify:**
- `app/existing/file.rb` (what changes needed)
- `config/routes.rb` (add new routes)

**Database Changes (if applicable):**
```ruby
# Migration description
add_column :table, :column_name, :type, options
add_index :table, :column_name
```

**Acceptance Criteria:**
- <Specific testable outcome>
- <Another outcome>
- <Final outcome>

---

#### Task 2: <Another Feature> (<AC Number>)

**Status:** <Status>
**Estimate:** X-Y hours | **Actual:** <If complete>

**Subtasks:**
- [ ] Step 1
- [ ] Step 2
- [ ] Step 3

**Implementation Notes:**
- <Technical detail>
- <Architecture decision>
- <Performance consideration>

**Testing Strategy:**
- Unit tests for <component>
- Integration tests for <flow>
- Browser tests for <user interaction>

**Acceptance Criteria:**
- <What must be true>
- <Another criterion>

---

## Dependencies & Risks

### External Dependencies

**What external systems, APIs, or services do we rely on?**

| Dependency | Purpose | Risk Level | Mitigation |
|------------|---------|------------|------------|
| <External API> | <What it's used for> | High/Medium/Low | <How we handle failures> |
| <Third-party Service> | <Purpose> | High/Medium/Low | <Backup plan> |

**Example:**
| Dependency | Purpose | Risk Level | Mitigation |
|------------|---------|------------|------------|
| Google Cloud Vision API | Text extraction | Medium | Local fallback, retry logic |
| Stripe API | Payment processing | High | Graceful degradation, status page monitoring |

### Technical Risks

**What technical challenges could block progress?**

- **<Risk Name>:** Description of the risk
  - **Likelihood:** High/Medium/Low
  - **Impact:** High/Medium/Low
  - **Mitigation:** How we'll address it

**Example:**
- **API Rate Limiting:** External API may throttle requests
  - **Likelihood:** Medium
  - **Impact:** High
  - **Mitigation:** Implement exponential backoff, request queuing

### Team/Resource Risks

**What non-technical factors could cause delays?**

- **<Risk Name>:** Description
  - **Mitigation:** Action plan

---

## Open Questions

**What needs clarification before we can proceed?**

### Q1: <Question Topic>
**Question:** <What needs to be answered?>
**Blocking:** <What task/milestone this blocks>
**Options:**
- a) <Option 1>
- b) <Option 2>
- c) <Option 3>

**Recommendation:** <Suggested approach>
**Decision Needed By:** <Date or milestone>

### Q2: <Another Question>
**Question:** <The question>
**Answer:** <Known answer or "TBD">

---

## Progress Tracking

### Velocity & Estimates

**Track actual vs estimated time to improve future estimates**

| Feature | Estimated | Actual | Variance | Notes |
|---------|-----------|--------|----------|-------|
| <Feature 1> | 3 hours | 2.5 hours | -0.5h | Faster than expected |
| <Feature 2> | 2 hours | 4 hours | +2h | Unexpected complexity |

**Average Velocity:** <X hours/day or Y story points/week>

### Milestone Progress

**Visual progress tracker**

**M1 - <Milestone Name>:** ✅✅✅✅✅✅✅ (7/7 ACs complete - 100%)
**M2 - <Current Milestone>:** ✅✅✅✅⬜⬜⬜ (4/7 ACs complete - 57%)
**M3 - <Future Milestone>:** ⬜⬜⬜⬜⬜ (0/5 ACs complete - 0%)

---

## Technical Debt

**Track shortcuts taken that need to be addressed later**

| Item | Created | Priority | Estimated Fix | Notes |
|------|---------|----------|---------------|-------|
| <Debt item> | <Date> | High/Medium/Low | X hours | <Why it exists, when to fix> |

**Example:**
| Item | Created | Priority | Estimated Fix | Notes |
|------|---------|----------|---------------|-------|
| N+1 queries in upload index | 2025-01-15 | Medium | 1 hour | Add eager loading, address in M3 |
| Missing error handling in job | 2025-01-20 | High | 2 hours | Can cause silent failures |

---

## Changelog

**Track major updates to this plan**

### 2025-XX-XX
- **Added:** <What was added>
- **Changed:** <What changed>
- **Removed:** <What was removed>

### 2025-XX-XX
- **Completed:** M1 milestone
- **Started:** M2 work
- **Updated:** Task estimates based on M1 velocity

---

## How to Use This Document

**For Claude Code:**
1. Check current sprint goals before starting work
2. Update task status and actual hours as work completes
3. Move completed features to "Completed" section
4. Add new tasks to sprint backlog as needed
5. Update changelog when making significant changes

**For Project Managers:**
1. Review progress tracking weekly
2. Update milestone targets based on velocity
3. Prioritize tasks based on dependencies
4. Escalate blocked tasks to open questions

**For Developers:**
1. Refer to detailed tasks for implementation guidance
2. Update acceptance criteria checkboxes as you work
3. Note actual hours for better future estimates
4. Flag risks and blockers in open questions
