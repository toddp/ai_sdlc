# 40 — Security & Privacy

## Data Classification (customize)
- Public / Internal / Confidential / Sensitive

## Threat Model Checklist
- Authn/Authz, least privilege
- Input validation & sanitization
- Secrets via env/vault; rotate regularly
- No secrets/PII in logs; correlation IDs
- Rate limiting & abuse controls on external endpoints
- Dependency SCA; pin versions; monitor CVEs

## SQL Injection Prevention (CRITICAL)

**ALWAYS use parameterized queries. NEVER use string interpolation in SQL.**

### Rails/ActiveRecord Best Practices

```ruby
# ✅ SAFE - Parameterized query with placeholder
User.where("email = ?", user_input)

# ✅ SAFE - Hash conditions (ActiveRecord automatically parameterizes)
User.where(email: user_input)

# ✅ SAFE - sanitize_sql_array for complex queries
sql = ActiveRecord::Base.sanitize_sql_array([
  "UPDATE users SET name = ? WHERE id = ?",
  user_name,
  user_id
])
ActiveRecord::Base.connection.execute(sql)

# ✅ SAFE - connection.quote for individual values
quoted_value = ActiveRecord::Base.connection.quote(user_input)
sql = "SELECT * FROM users WHERE email = #{quoted_value}"

# ❌ UNSAFE - String interpolation (SQL INJECTION RISK!)
User.where("email = '#{user_input}'")  # DO NOT DO THIS

# ❌ UNSAFE - Direct string concatenation
sql = "UPDATE users SET name = '" + user_name + "'"  # DO NOT DO THIS
```

### PostgreSQL/PostGIS Queries

When using raw SQL with PostGIS functions, always parameterize:

```ruby
# ✅ SAFE - Parameterized PostGIS query
sql = ActiveRecord::Base.sanitize_sql_array([
  "SELECT * FROM parcels WHERE ST_Intersects(geom, ST_GeomFromText(?, 4326))",
  wkt_geometry
])

# ✅ SAFE - Quote WKT strings
wkt_quoted = ActiveRecord::Base.connection.quote(wkt_string)
sql = "INSERT INTO permits (geom) VALUES (ST_GeomFromText(#{wkt_quoted}, 4326))"

# ❌ UNSAFE - Interpolating geometry WKT
sql = "SELECT * FROM parcels WHERE ST_Intersects(geom, ST_GeomFromText('#{wkt}', 4326))"
```

### UPDATE/INSERT with Dynamic Values

```ruby
# ✅ SAFE - Use sanitize_sql_array
sql = ActiveRecord::Base.sanitize_sql_array([
  "UPDATE permits SET parcel_uid = f.parcel_uid
   FROM parcels_fl f
   WHERE permits.parcel_id_raw = f.parcel_id_raw
     AND f.county_fips = ?
     AND permits.source_batch_id = ?",
  county_fips,
  batch_id
])
ActiveRecord::Base.connection.execute(sql)

# ❌ UNSAFE - String interpolation
sql = "UPDATE permits SET parcel_uid = '#{parcel_uid}'"  # SQL INJECTION RISK
```

### Code Review Checklist

Before merging any PR with SQL:
- [ ] All raw SQL uses `sanitize_sql_array` or `connection.quote`
- [ ] No string interpolation (`#{}`) in SQL strings
- [ ] No string concatenation (`+`) in SQL strings
- [ ] ActiveRecord query methods use `?` placeholders or hash conditions
- [ ] PostGIS WKT strings are quoted with `connection.quote`

## Secrets Policy
- Use `${VAR}` and document in RUNBOOK.
- Provide `.env.example` with placeholders.
- Never commit live secrets.
