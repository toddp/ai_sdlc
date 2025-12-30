# ADR <nnn>: <Decision Title>

<!-- Example: ADR 011: Thumbnail Extraction Strategy -->

- **Status:** Proposed | Accepted | Rejected | Superseded by ADR-xxx
- **Date:** <YYYY-MM-DD>
- **Authors:** <Claude Code | Team Member Name>
- **Related SPEC:** [SPEC-xxx-feature-name.md](../SPECS/SPEC-xxx-feature-name.md) _(if applicable)_

---

## Context

**What problem are we solving?**
- Describe the technical or business problem that requires a decision
- Include background information that helps readers understand why this matters
- List specific requirements or constraints that influence the decision

**Example:**
> The upload show page currently displays text-only video cards without visual previews. Users need to see thumbnails for videos because:
> 1. Quickly identify which TikTok content was processed
> 2. Visually confirm correct videos were extracted
> 3. Preview slideshow images before reading text
>
> **Requirements:**
> - Display video thumbnails inline (200x200px)
> - Handle both external and self-extracted frames
> - Graceful fallback if extraction fails

---

## Decision

**What did we decide to do?**
- State the chosen solution clearly and concisely
- Include architecture overview if applicable
- Show code examples or diagrams if helpful

**Example:**
> **We will implement a three-tier thumbnail extraction strategy:**
>
> ### Tier 1: External API (Preferred)
> Try to use thumbnail URL provided by external service
>
> ### Tier 2: Local Extraction (Fallback)
> Extract frame from downloaded file using processing tool
>
> ### Tier 3: Placeholder (Last Resort)
> Display generic icon if both fail
>
> ### Architecture
>
> ```ruby
> class ThumbnailExtractor
>   def call
>     thumbnail_path = if external_thumbnail_available?
>       download_external_thumbnail    # Tier 1
>     else
>       extract_frame_from_file        # Tier 2
>     end
>
>     return show_placeholder unless thumbnail_path  # Tier 3
>     upload_to_storage(thumbnail_path)
>   end
> end
> ```

---

## Alternatives Considered

**What other options did we evaluate?**

List each alternative with:
- **Approach:** Brief description or code example
- **Pros:** What makes this option attractive
- **Cons:** What are the drawbacks (mark dealbreakers with ❌)
- **Decision:** Why was it rejected or selected (mark selected with ✅)

### Option A: <Name> (Rejected | Selected)

**Approach:**
```
Code example or description
```

**Pros:**
- Fast implementation
- No new dependencies

**Cons:**
- ❌ No fallback if external service fails
- ❌ User sees placeholder for many items

**Decision:** Rejected - too many items would lack thumbnails

---

### Option B: <Name> (Rejected | Selected)

**Approach:**
```
Alternative approach
```

**Pros:**
- Consistent quality
- Full control over output

**Cons:**
- ❌ Requires additional processing time
- ❌ Adds external dependency

**Decision:** Rejected - wasteful if external source available

---

### Option C: <Name> (Selected) ✅

**Approach:**
```
The chosen approach
```

**Pros:**
- ✅ Best balance of speed and reliability
- ✅ Graceful degradation
- ✅ Maximizes availability

**Cons:**
- More complex implementation
- Additional dependency required

**Decision:** Selected - provides best user experience

---

## Decision Details

**Expand on specific aspects of the decision:**

### 1. <Aspect Name> (e.g., Storage Strategy, Data Format, API Design)

**Chosen:** <What was chosen>

**Rationale:**
- Why this choice makes sense
- How it aligns with requirements
- How it fits existing architecture

**Schema/Config Changes:**
```
Code showing migrations, config, or data structures
```

### 2. <Another Aspect> (e.g., Processing Timing, Error Handling)

**Chosen:** <What was chosen>

**Rationale:**
- Explanation of the choice
- Trade-offs considered

**Implementation:**
```
Code showing how it works
```

---

## Consequences

### Positive

**What benefits does this decision provide?**

1. **<Benefit Category>**
   - Specific positive outcome
   - Another positive outcome

2. **<Another Benefit>**
   - How this helps users or developers
   - Measurable improvement if applicable

### Negative

**What costs or risks does this decision introduce?**

1. **<Cost or Risk>**
   - Specific negative impact
   - Estimated magnitude (High/Medium/Low)
   - Mitigation: How we'll address this

2. **<Another Cost>**
   - What we're giving up or taking on
   - Mitigation strategy

### Risks & Mitigations

| Risk | Impact | Mitigation |
|------|--------|------------|
| External service changes format | Medium | Fallback to local extraction |
| Processing tool fails | Low | Fallback to placeholder |
| Storage costs grow | Medium | Cleanup job, monitor usage |

---

## Implementation Checklist

**Break down the work into phases:**

### Phase 1: <Phase Name> (e.g., Core Logic)
- [ ] Task 1
- [ ] Task 2
- [ ] Task 3

### Phase 2: <Phase Name> (e.g., UI Components)
- [ ] Task 1
- [ ] Task 2

### Phase 3: Testing
- [ ] Unit tests
- [ ] Integration tests
- [ ] Performance tests

### Phase 4: Deployment
- [ ] Infrastructure changes
- [ ] Configuration updates
- [ ] Documentation

---

## Open Questions

**What remains unclear or needs follow-up?**

### Q1: <Question Topic>
**Question:** What specifically needs clarification
**Action:** What to do to resolve it
**Owner:** Who will investigate

### Q2: <Another Question>
**Question:** The open question
**Answer:** Answer if known, or "Deferred - will address in phase 2"

---

## References

**Links to related documentation:**
- [SPEC-xxx-feature-name.md](../SPECS/SPEC-xxx-feature-name.md) - Full specification
- [External Documentation](https://example.com/docs) - Relevant external docs
- [Handbook Section](/docs/standards/10-Architecture-Principles.md) - Applicable principles
- [Related ADR](./ADR-xxx-related-decision.md) - Related decision

---

## Approval Status

- [ ] Reviewed by: _____________
- [ ] Approved: Yes / No
- [ ] Date: _____________
