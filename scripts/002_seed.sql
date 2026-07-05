-- =============================================================
-- GPT Hubli Management System — Seed Data
-- Run AFTER 001_schema.sql:  psql "$DATABASE_URL" -f scripts/002_seed.sql
-- Default root admin:  Akshay (akshay@gpthubli.ac.in) / Zaq1Zaq2$123
-- Manual test accounts (Akshay Uppar) use password: Test@123
-- =============================================================

-- ---------- Students ----------
INSERT INTO students (reg_no, name, dept, year, cgpa, att, father) VALUES
  ('GP2025CSE001', 'Akshay Uppar', 'Computer Science Engineering', '2nd Year', '8.5', '91%', 'Mr. B. Uppar')
ON CONFLICT (reg_no) DO NOTHING;

-- ---------- Results (Akshay Uppar sem 3) ----------
WITH r AS (
  INSERT INTO results (reg_no, name, branch, sem, session, sgpa, result)
  VALUES ('GP2025CSE001','Akshay Uppar','Computer Science Engineering',3,'APR/MAY 2026',8.5,'Pass')
  ON CONFLICT (reg_no, sem, session) DO NOTHING
  RETURNING id
)
INSERT INTO result_subjects (result_id, name, code, internal, external, credits, grade, ord)
SELECT id, s.* FROM r, (VALUES
  ('Data Structures','CS301',40,74,4,'A',1),
  ('Database Systems','CS302',43,70,4,'A',2),
  ('Computer Networks','CS303',38,60,3,'A',3),
  ('Engineering Maths III','MA301',42,78,4,'A+',4),
  ('Digital Electronics','CS304',37,64,3,'A',5)
) AS s(name, code, internal, external, credits, grade, ord);

-- ---------- Committees ----------
INSERT INTO committees (name, icon, color) VALUES
  ('SC/ST Committee','⚖️','primary'),
  ('Internal Quality Assurance Cell','🏅','purple'),
  ('Women/Girl Students Grievance Cell','👩','green'),
  ('Anti-Ragging Squad','🚫','red'),
  ('Grievance Redressal','📋','accent'),
  ('Anti-Ragging Committee','🛡️','teal'),
  ('Institute Industry Cell','🏭','orange'),
  ('Internal Complaint Committee','📝','primary'),
  ('Media Cell','📢','purple')
ON CONFLICT (name) DO NOTHING;

-- ---------- Notices ----------
INSERT INTO notices (title, body, priority) VALUES
  ('Diploma Exam Time Table Released — APR/MAY 2026', 'The examination time table for APR/MAY 2026 has been published. Check the Exam Cell section for details.', 'important'),
  ('Admissions Open for 2026-27 Academic Year', 'Applications are invited for all diploma programmes. Visit the college office for admission forms.', 'normal'),
  ('Campus Placement Drive — Infosys & TCS', 'Final-year students must register with the Placement Cell before the deadline.', 'important');

-- ---------- Users: root admin + manual test accounts ----------
-- Root admin — login with username "Akshay" or the full email
INSERT INTO users (email, password_hash, role, display_name, status, force_password_change, is_demo)
VALUES ('akshay@gpthubli.ac.in', crypt('Zaq1Zaq2$123', gen_salt('bf', 10)), 'admin', 'Akshay', 'approved', FALSE, FALSE)
ON CONFLICT (email) DO NOTHING;

-- Manual test accounts for Akshay Uppar (password: Test@123) — one per role module
INSERT INTO users (email, password_hash, role, display_name, reg_no, status, is_demo)
VALUES
  ('auppar44@gmail.com',              crypt('Test@123', gen_salt('bf', 10)), 'admin',        'Akshay Uppar', NULL,           'approved', FALSE),
  ('auppar44+student@gmail.com',      crypt('Test@123', gen_salt('bf', 10)), 'student',      'Akshay Uppar', 'GP2025CSE001', 'approved', FALSE),
  ('auppar44+principal@gmail.com',    crypt('Test@123', gen_salt('bf', 10)), 'principal',    'Akshay Uppar', NULL,           'approved', FALSE),
  ('auppar44+hod@gmail.com',          crypt('Test@123', gen_salt('bf', 10)), 'hod',          'Akshay Uppar', NULL,           'approved', FALSE),
  ('auppar44+faculty@gmail.com',      crypt('Test@123', gen_salt('bf', 10)), 'faculty',      'Akshay Uppar', NULL,           'approved', FALSE),
  ('auppar44+registrar@gmail.com',    crypt('Test@123', gen_salt('bf', 10)), 'registrar',    'Akshay Uppar', NULL,           'approved', FALSE),
  ('auppar44+acm@gmail.com',          crypt('Test@123', gen_salt('bf', 10)), 'acm',          'Akshay Uppar', NULL,           'approved', FALSE),
  ('auppar44+exam@gmail.com',         crypt('Test@123', gen_salt('bf', 10)), 'exam',         'Akshay Uppar', NULL,           'approved', FALSE),
  ('auppar44+est@gmail.com',          crypt('Test@123', gen_salt('bf', 10)), 'est',          'Akshay Uppar', NULL,           'approved', FALSE),
  ('auppar44+library@gmail.com',      crypt('Test@123', gen_salt('bf', 10)), 'library',      'Akshay Uppar', NULL,           'approved', FALSE),
  ('auppar44+placement@gmail.com',    crypt('Test@123', gen_salt('bf', 10)), 'placement',    'Akshay Uppar', NULL,           'approved', FALSE),
  ('auppar44+nss@gmail.com',          crypt('Test@123', gen_salt('bf', 10)), 'nss',          'Akshay Uppar', NULL,           'approved', FALSE),
  ('auppar44+yrc@gmail.com',          crypt('Test@123', gen_salt('bf', 10)), 'yrc',          'Akshay Uppar', NULL,           'approved', FALSE),
  ('auppar44+alumni@gmail.com',       crypt('Test@123', gen_salt('bf', 10)), 'alumni',       'Akshay Uppar', NULL,           'approved', FALSE),
  ('auppar44+sports@gmail.com',       crypt('Test@123', gen_salt('bf', 10)), 'sports',       'Akshay Uppar', NULL,           'approved', FALSE),
  ('auppar44+welfare@gmail.com',      crypt('Test@123', gen_salt('bf', 10)), 'welfare',      'Akshay Uppar', NULL,           'approved', FALSE),
  ('auppar44+cash@gmail.com',         crypt('Test@123', gen_salt('bf', 10)), 'cash',         'Akshay Uppar', NULL,           'approved', FALSE),
  ('auppar44+accounts@gmail.com',     crypt('Test@123', gen_salt('bf', 10)), 'accounts',     'Akshay Uppar', NULL,           'approved', FALSE),
  ('auppar44+stores@gmail.com',       crypt('Test@123', gen_salt('bf', 10)), 'stores',       'Akshay Uppar', NULL,           'approved', FALSE),
  ('auppar44+studentassoc@gmail.com', crypt('Test@123', gen_salt('bf', 10)), 'studentassoc', 'Akshay Uppar', NULL,           'approved', FALSE)
ON CONFLICT (email) DO NOTHING;
