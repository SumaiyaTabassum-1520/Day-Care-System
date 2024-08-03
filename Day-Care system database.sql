-- Create Name Type
CREATE OR REPLACE TYPE NameType AS OBJECT (
  first_name VARCHAR2(50),
  last_name VARCHAR2(50)
);

-- Create Address Type
CREATE OR REPLACE TYPE AddressType AS OBJECT (
  line VARCHAR2(50),
  city VARCHAR2(50),
  zip VARCHAR2(50)
);

-- Create Mobile Number List Type
CREATE OR REPLACE TYPE MobileNumberList AS TABLE OF VARCHAR2(20);

-- Create Email List Type
CREATE OR REPLACE TYPE EmailList AS TABLE OF VARCHAR2(100);

-- Create Contact Info Type
CREATE OR REPLACE TYPE ContactInfoType AS OBJECT (
  mobile_numbers MobileNumberList,
  emails EmailList
);

-- Create Attendance Record Type
CREATE OR REPLACE TYPE AttendanceRecordType AS OBJECT (
  date DATE,
  check_in_time VARCHAR2(20),
  check_out_time VARCHAR2(20)
);

-- Create Attendance Record List Type
CREATE OR REPLACE TYPE AttendanceRecordList AS TABLE OF AttendanceRecordType;

-- Create Activity Log Type
CREATE OR REPLACE TYPE ActivityLogType AS OBJECT (
  activity_date DATE,
  description VARCHAR2(200)
);

-- Create Activity Log List Type
CREATE OR REPLACE TYPE ActivityLogList AS TABLE OF ActivityLogType;

-- Create Payment Details Type
CREATE OR REPLACE TYPE PaymentDetailsType AS OBJECT (
  amount NUMBER(10, 2),
  due_date DATE,
  payment_status VARCHAR2(20)
);
--parent table
CREATE TABLE parent (
  parent_id VARCHAR2(50) PRIMARY KEY,
  name NameType,
  address AddressType,
  contact_info ContactInfoType
) 
NESTED TABLE contact_info.mobile_numbers STORE AS parent_mobile_numbers_nt
NESTED TABLE contact_info.emails STORE AS parent_emails_nt;
/
--classgroup table
CREATE TABLE classgroup (
  classgroup_id VARCHAR2(50) PRIMARY KEY,
  name VARCHAR2(50),
  age_range VARCHAR2(20),
  schedule VARCHAR2(200)
);
/
--create child table
CREATE TABLE child (
  child_id VARCHAR2(50) PRIMARY KEY,
  name NameType,
  age NUMBER(3),
  contact_info ContactInfoType,
  attendence_record AttendanceRecordList,
  activity_log ActivityLogList,
  parent_id VARCHAR2(50),
  classgroup_id VARCHAR2(50),
  FOREIGN KEY (parent_id) REFERENCES parent(parent_id),
  FOREIGN KEY (classgroup_id) REFERENCES classgroup(classgroup_id)
) 
NESTED TABLE contact_info.mobile_numbers STORE AS child_mobile_numbers_nt
NESTED TABLE contact_info.emails STORE AS child_emails_nt
NESTED TABLE attendence_record STORE AS child_attendance_records_nt
NESTED TABLE activity_log STORE AS child_activity_logs_nt;
/

--staff table
CREATE TABLE staff (
  staff_id VARCHAR2(50) PRIMARY KEY,
  name NameType,
  address AddressType,
  contact_info ContactInfoType,
  role VARCHAR2(50),
  qualifications VARCHAR2(100),
  schedule VARCHAR2(200),
  attendence_records AttendanceRecordList,
  payroll_number VARCHAR2(50),
  classgroup_id VARCHAR2(50),
  FOREIGN KEY (classgroup_id) REFERENCES classgroup(classgroup_id)
)
NESTED TABLE contact_info.mobile_numbers STORE AS staff_mobile_numbers_nt
NESTED TABLE contact_info.emails STORE AS staff_emails_nt
NESTED TABLE attendence_records STORE AS staff_attendance_records_nt;
/

--invoice table 
CREATE TABLE invoice (
  invoice_id VARCHAR2(50) PRIMARY KEY,
  payment_details PaymentDetailsType,
  child_id VARCHAR2(50),
  FOREIGN KEY (child_id) REFERENCES child(child_id)
);
/

--meal table
CREATE TABLE meal (
  meal_id VARCHAR2(50) PRIMARY KEY,
  type VARCHAR2(50),
  serve_date DATE,
  description VARCHAR2(200),
  classgroup_id VARCHAR2(50),
  FOREIGN KEY (classgroup_id) REFERENCES classgroup(classgroup_id)
);
/

--activity table
CREATE TABLE activity (
  activity_id VARCHAR2(50) PRIMARY KEY,
  activity_date DATE,
  name VARCHAR2(50),
  description VARCHAR2(200),
  classgroup_id VARCHAR2(50),
  FOREIGN KEY (classgroup_id) REFERENCES classgroup(classgroup_id)
);
/

--medical_staff table
CREATE TABLE medical_staff (
  medical_staff_id VARCHAR2(50) PRIMARY KEY,
  name NameType,
  qualifications VARCHAR2(100),
  contact_info ContactInfoType
)
NESTED TABLE contact_info.mobile_numbers STORE AS medical_staff_mobile_numbers_nt
NESTED TABLE contact_info.emails STORE AS medical_staff_emails_nt;
/

--event table
CREATE TABLE event (
  event_id VARCHAR2(50) PRIMARY KEY,
  event_date DATE,
  name VARCHAR2(50),
  description VARCHAR2(200),
  classgroup_id VARCHAR2(50),
  FOREIGN KEY (classgroup_id) REFERENCES classgroup(classgroup_id)
);
/


--Data insert into parent table

INSERT INTO parent (
  parent_id,
  name,
  contact_info
) VALUES (
  '001',
  NameType('abu', 'sayed'),
  ContactInfoType(
    MobileNumberList('017-34567892', '019-76543231'),
    EmailList('abu@gmail.com', 'sayed@gmail.com'),
    AddressType('shantinagar', 'dhaka', '1217')
  )
);

INSERT INTO parent (
  parent_id,
  name,
  contact_info
) VALUES (
  '002',
  NameType('nasima', 'akter'),
  ContactInfoType(
    MobileNumberList('017-34537892', '019-76243231'),
    EmailList('nasima@gmail.com', 'akter@gmail.com'),
    AddressType('malibagh', 'dhaka', '1217')
  )
);

INSERT INTO parent (
  parent_id,
  name,
  contact_info
) VALUES (
  '003',
  NameType('jahidul', 'islam'),
  ContactInfoType(
    MobileNumberList('018-34567892', '019-76543231'),
    EmailList('jahid@gmail.com', 'jahidul@gmail.com'),
    AddressType('kakrail', 'dhaka', '1217')
  )
);

INSERT INTO parent (
  parent_id,
  name,
  contact_info
) VALUES (
  '004',
  NameType('nargis', 'akter'),
  ContactInfoType(
    MobileNumberList('017-33567892', '019-72543231'),
    EmailList('nargis@gmail.com', 'akter@gmail.com'),
    AddressType('siddeswari', 'dhaka', '1214')
  )
);

INSERT INTO parent (
  parent_id,
  name,
  contact_info
) VALUES (
  '005',
  NameType('shahin', 'zia'),
  ContactInfoType(
    MobileNumberList('017-36567892', '019-76543231'),
    EmailList('shahin@gmail.com', 'zia@gmail.com'),
    AddressType('dhanmondi', 'dhaka', '1518')
  )
);

INSERT INTO parent (
  parent_id,
  name,
  contact_info
) VALUES (
  '006',
  NameType('mizanur', 'rahman'),
  ContactInfoType(
    MobileNumberList('017-56567892', '019-72343231'),
    EmailList('mijan@gmail.com', 'babul@gmail.com'),
    AddressType('shatora', 'cumilla', '112')
  )
);

INSERT INTO parent (
  parent_id,
  name,
  contact_info
) VALUES (
  '007',
  NameType('yesmin', 'shilpi'),
  ContactInfoType(
    MobileNumberList('017-34467892', '013-76523231','019-76523231'),
    EmailList('yesmin@gmail.com', 'shilpi@gmail.com'),
    AddressType('bagmara', 'cumilla', '123')
  )
);

INSERT INTO parent (
  parent_id,
  name,
  contact_info
) VALUES (
  '008',
  NameType('kausar', 'lipi'),
  ContactInfoType(
    MobileNumberList('017-34567992', '019-76541231'),
    EmailList('kausar@gmail.com', 'lipi@gmail.com'),
    AddressType('bijoypur', 'cumilla', '189')
  )
);

INSERT INTO parent (
  parent_id,
  name,
  contact_info
) VALUES (
  '009',
  NameType('farida', 'yesmin'),
  ContactInfoType(
    MobileNumberList('017-34567892', '018-76543231','017-54567892'),
    EmailList('farida@gmail.com', 'yesmin@gmail.com', 'shonom@gmail.com'),
    AddressType('shilapara', 'cox's bazar', '34')
  )
);

INSERT INTO parent (
  parent_id,
  name,
  contact_info
) VALUES (
  '010',
  NameType('ashiqur', 'rahman'),
  ContactInfoType(
    MobileNumberList('013-34567892', '017-76543231', '018-76543231'),
    EmailList('ashiqur@gmail.com', 'rahman@gmail.com'),
    AddressType('mohakhali', 'dhaka', '121')
  )
);

INSERT INTO parent (
  parent_id,
  name,
  contact_info
) VALUES (
  '011',
  NameType('farjana', 'kabir'),
  ContactInfoType(
    MobileNumberList('013-34567892', '019-36543231'),
    EmailList('farjana@gmail.com', 'kabir@gmail.com'),
    AddressType('karnafuli', 'chittagong', '127')
  )
);

INSERT INTO parent (
  parent_id,
  name,
  contact_info
) VALUES (
  '012',
  NameType('kabir', 'badal'),
  ContactInfoType(
    MobileNumberList('017-34567832', '019-76543231'),
    EmailList('kabir@gmail.com', 'badal@gmail.com'),
    AddressType('halishohor', 'chittagong', '117')
  )
);

INSERT INTO parent (
  parent_id,
  name,
  contact_info
) VALUES (
  '013',
  NameType('marufa', 'yesmin'),
  ContactInfoType(
    MobileNumberList('017-34567892', '015-76543231'),
    EmailList('marufa@gmail.com', 'yesmin@gmail.com'),
    AddressType('raujan', 'khulna', '127')
  )
);

INSERT INTO parent (
  parent_id,
  name,
  contact_info
) VALUES (
  '014',
  NameType('ruksana', 'yesmin'),
  ContactInfoType(
    MobileNumberList('015-34567892', '013-76543231'),
    EmailList('ruksana@gmail.com', 'yesmin@gmail.com'),
    AddressType('betbari', 'rangpur', '1217')
  )
);

INSERT INTO parent (
  parent_id,
  name,
  contact_info
) VALUES (
  '015',
  NameType('shama', 'jahan'),
  ContactInfoType(
    MobileNumberList('017-34567893', '019-76542231'),
    EmailList('samira@gmail.com', 'jahan@gmail.com'),
    AddressType('meherpur', 'rajshahi', '1217')
  )
);

---insert into classgroup
INSERT INTO classgroup (
  classgroup_id,
  name,
  age_range,
  schedule
) VALUES (
  'CG001',
  'Infant',
  '1-3 years',
  'Monday to Friday, 9:00 AM - 12:00 PM'
);

INSERT INTO classgroup (
  classgroup_id,
  name,
  age_range,
  schedule
) VALUES (
  'CG002',
  'Preschooler',
  '3-5 years',
  'Monday to Friday, 1:00 PM - 4:00 PM'
);

INSERT INTO classgroup (
  classgroup_id,
  name,
  age_range,
  schedule
) VALUES (
  'CG003',
  'school aged',
  '5-12 years',
  'Monday to Friday, 4:00 PM - 6:00 PM'
);

INSERT INTO classgroup (
  classgroup_id,
  name,
  age_range,
  schedule
) VALUES (
  'CG004',
  'newborn',
  '0-1 years',
  'Monday to Friday, 8:00 AM - 5:00 PM'
);

INSERT INTO classgroup (
  classgroup_id,
  name,
  age_range,
  schedule
) VALUES (
  'CG005',
  'Toddler',
  '4-6 years',
  'Monday to Friday, 8:30 AM - 3:30 PM'
);

INSERT INTO classgroup (
  classgroup_id,
  name,
  age_range,
  schedule
) VALUES (
  'CG006',
  'school aged',
  '5-12 years',
  'Monday to Friday, 9:00 AM - 4:00 PM'
);

INSERT INTO classgroup (
  classgroup_id,
  name,
  age_range,
  schedule
) VALUES (
  'CG007',
  'school aged',
  '6-9 years',
  'Monday to Friday, 2:00 PM - 5:00 PM'
);

INSERT INTO classgroup (
  classgroup_id,
  name,
  age_range,
  schedule
) VALUES (
  'CG008',
  'school aged',
  '3-10 years',
  'Monday to Friday, 10:00 AM - 3:00 PM'
);

INSERT INTO classgroup (
  classgroup_id,
  name,
  age_range,
  schedule
) VALUES (
  'CG009',
  'infant',
  '1-2 years',
  'Tuesday and Thursday, 10:30 AM - 11:30 AM'
);

INSERT INTO classgroup (
  classgroup_id,
  name,
  age_range,
  schedule
) VALUES (
  'CG010',
  'preschool',
  '1-3 years',
  'Wednesday and Friday, 9:30 AM - 11:30 AM'
);

INSERT INTO classgroup (
  classgroup_id,
  name,
  age_range,
  schedule
) VALUES (
  'CG012',
  'school aged',
  '7-10 years',
  'Saturday, 10:00 AM - 12:00 PM'
);



-----insert data into child
INSERT INTO child (
  child_id,
  name,
  age,
  contact_info,
  attendence_record,
  activity_log,
  parent_id,
  classgroup_id
) VALUES (
  'CH001',
  NameType('sidratul', 'muntaha'),
  3,
  ContactInfoType(MobileNumberList('01745678920'), EmailList('muntaha@gmail.com'), AddressType('shantinagar', 'dhaka', '1217')),
  AttendanceRecordList(AttendanceRecordType(TO_DATE('2023-06-01', 'YYYY-MM-DD'), '09:00', '12:00')),
  ActivityLogList(ActivityLogType(TO_DATE('2023-06-01', 'YYYY-MM-DD'), 'playing')),
  '001',
  'CG002'
);

-- Insert data into child table
INSERT INTO child (
  child_id,
  name,
  age,
  contact_info,
  attendence_record,
  activity_log,
  parent_id,
  classgroup_id
) VALUES (
  'CH001',
  NameType('John', 'Doe'),
  4,
  ContactInfoType(MobileNumberList('1234567890'), EmailList('john.doe@example.com'), AddressType('123 Elm St', 'Springfield', '12345')),
  AttendanceRecordList(AttendanceRecordType(TO_DATE('2023-06-01', 'YYYY-MM-DD'), '09:00', '12:00')),
  ActivityLogList(ActivityLogType(TO_DATE('2023-06-01', 'YYYY-MM-DD'), 'Painting')),
  'P001',
  'CG002'
);

INSERT INTO child (
  child_id,
  name,
  age,
  contact_info,
  attendence_record,
  activity_log,
  parent_id,
  classgroup_id
) VALUES (
  'CH002',
  NameType('ahnaf', 'tahmid'),
  4,
  ContactInfoType(MobileNumberList('01876543210'), EmailList('ahnaf@gmail.com'), AddressType('malibagh', 'dhaka', '1217')),
  AttendanceRecordList(AttendanceRecordType(TO_DATE('2023-06-01', 'YYYY-MM-DD'), '09:00', '12:00')),
  ActivityLogList(ActivityLogType(TO_DATE('2023-06-01', 'YYYY-MM-DD'), 'Drawing')),
  '002',
  'CG002'
);

INSERT INTO child (
  child_id,
  name,
  age,
  contact_info,
  attendence_record,
  activity_log,
  parent_id,
  classgroup_id
) VALUES (
  'CH003',
  NameType('fouzia', 'tasnim'),
  5,
  ContactInfoType(MobileNumberList('5551234567'), EmailList('fouzia@gmail.com'), AddressType('kakrail', 'dhaka', '1217')),
  AttendanceRecordList(AttendanceRecordType(TO_DATE('2023-06-01', 'YYYY-MM-DD'), '01:00', '04:00')),
  ActivityLogList(ActivityLogType(TO_DATE('2023-06-01', 'YYYY-MM-DD'), 'Story Time')),
  '003',
  'CG003'
);

INSERT INTO child (
  child_id,
  name,
  age,
  contact_info,
  attendence_record,
  activity_log,
  parent_id,
  classgroup_id
) VALUES (
  'CH004',
  NameType('fabiha', 'tasnim'),
  2,
  ContactInfoType(MobileNumberList('4445678901'), EmailList('fabiha@gmail.com'), AddressType('siddeswari', 'dhaka', '1214')),
  AttendanceRecordList(AttendanceRecordType(TO_DATE('2023-06-01', 'YYYY-MM-DD'), '09:00', '12:00')),
  ActivityLogList(ActivityLogType(TO_DATE('2023-06-01', 'YYYY-MM-DD'), 'Building Blocks')),
  '004',
  'CG001'
);

INSERT INTO child (
  child_id,
  name,
  age,
  contact_info,
  attendence_record,
  activity_log,
  parent_id,
  classgroup_id
) VALUES (
  'CH005',
  NameType('muntaka', 'sadia'),
  6,
  ContactInfoType(MobileNumberList('3336789012'), EmailList('muntaka@gmail.com'), AddressType('dhanmondi', 'dhaka', '1518')),
  AttendanceRecordList(AttendanceRecordType(TO_DATE('2023-06-01', 'YYYY-MM-DD'), '09:00', '12:00')),
  ActivityLogList(ActivityLogType(TO_DATE('2023-06-01', 'YYYY-MM-DD'), 'Reading')),
  '005',
  'CG003'
);

INSERT INTO child (
  child_id,
  name,
  age,
  contact_info,
  attendence_record,
  activity_log,
  parent_id,
  classgroup_id
) VALUES (
  'CH006',
  NameType('Sara', 'akter'),
  4,
  ContactInfoType(MobileNumberList('2227890123'), EmailList('sara@gmail.com'), AddressType('shatora', 'cumilla', '112')),
  AttendanceRecordList(AttendanceRecordType(TO_DATE('2023-06-01', 'YYYY-MM-DD'), '09:00', '12:00')),
  ActivityLogList(ActivityLogType(TO_DATE('2023-06-01', 'YYYY-MM-DD'), 'Outdoor Play')),
  '006',
  'CG002'
);

INSERT INTO child (
  child_id,
  name,
  age,
  contact_info,
  attendence_record,
  activity_log,
  parent_id,
  classgroup_id
) VALUES (
  'CH007',
  NameType('affan', 'bose'),
  3,
  ContactInfoType(MobileNumberList('1118901234'), EmailList('affan@gmail.com'), AddressType('bagmara', 'cumilla', '123')),
  AttendanceRecordList(AttendanceRecordType(TO_DATE('2023-06-01', 'YYYY-MM-DD'), '09:00', '12:00')),
  ActivityLogList(ActivityLogType(TO_DATE('2023-06-01', 'YYYY-MM-DD'), 'Singing')),
  '007',
  'CG002'
);

INSERT INTO child (
  child_id,
  name,
  age,
  contact_info,
  attendence_record,
  activity_log,
  parent_id,
  classgroup_id
) VALUES (
  'CH008',
  NameType('Sophia', 'haider'),
  2,
  ContactInfoType(MobileNumberList('6661234567'), EmailList('sophia@gmail.com'), AddressType('bijoypur', 'cumilla', '189')),
  AttendanceRecordList(AttendanceRecordType(TO_DATE('2023-06-01', 'YYYY-MM-DD'), '09:00', '12:00')),
  ActivityLogList(ActivityLogType(TO_DATE('2023-06-01', 'YYYY-MM-DD'), 'Puzzles')),
  '008',
  'CG001'
);

INSERT INTO child (
  child_id,
  name,
  age,
  contact_info,
  attendence_record,
  activity_log,
  parent_id,
  classgroup_id
) VALUES (
  'CH009',
  NameType('junayed', 'jafar'),
  5,
  ContactInfoType(MobileNumberList('7772345678'), EmailList('junayed@gmail.com'), AddressType('shilapara', 'cox bazar', '34')),
  AttendanceRecordList(AttendanceRecordType(TO_DATE('2023-06-01', 'YYYY-MM-DD'), '01:00', '04:00')),
  ActivityLogList(ActivityLogType(TO_DATE('2023-06-01', 'YYYY-MM-DD'), 'Art Class')),
  '009',
  'CG003'
);

INSERT INTO child (
  child_id,
  name,
  age,
  contact_info,
  attendence_record,
  activity_log,
  parent_id,
  classgroup_id
) VALUES (
  'CH010',
  NameType('shanta', 'roy'),
  4,
  ContactInfoType(MobileNumberList('8883456789'), EmailList('shanta@gmail.com'), AddressType('mohakhali', 'dhaka', '121')),
  AttendanceRecordList(AttendanceRecordType(TO_DATE('2023-06-01', 'YYYY-MM-DD'), '09:00', '12:00')),
  ActivityLogList(ActivityLogType(TO_DATE('2023-06-01', 'YYYY-MM-DD'), 'Dance')),
  '010',
  'CG002'
);

INSERT INTO child (
  child_id,
  name,
  age,
  contact_info,
  attendence_record,
  activity_log,
  parent_id,
  classgroup_id
) VALUES (
  'CH011',
  NameType('tamanna', 'jahan'),
  3,
  ContactInfoType(MobileNumberList('9994567890'), EmailList('tamanna@gmail.com'), AddressType('karnafuli', 'chittagong', '127')),
  AttendanceRecordList(AttendanceRecordType(TO_DATE('2023-06-01', 'YYYY-MM-DD'), '09:00', '12:00')),
  ActivityLogList(ActivityLogType(TO_DATE('2023-06-01', 'YYYY-MM-DD'), 'Clay Modeling')),
  '011',
  'CG002'
);

INSERT INTO child (
  child_id,
  name,
  age,
  contact_info,
  attendence_record,
  activity_log,
  parent_id,
  classgroup_id
) VALUES (
  'CH012',
  NameType('silvia', 'bose'),
  2,
  ContactInfoType(MobileNumberList('1235678901'), EmailList('silvia@gmail.com'), AddressType('halishohor', 'chittagong', '117')),
  AttendanceRecordList(AttendanceRecordType(TO_DATE('2023-06-01', 'YYYY-MM-DD'), '09:00', '12:00')),
  ActivityLogList(ActivityLogType(TO_DATE('2023-06-01', 'YYYY-MM-DD'), 'Story Time')),
  '012',
  'CG001'
);

INSERT INTO child (
  child_id,
  name,
  age,
  contact_info,
  attendence_record,
  activity_log,
  parent_id,
  classgroup_id
) VALUES (
  'CH013',
  NameType('kotha', 'hossain'),
  5,
  ContactInfoType(MobileNumberList('2346789012'), EmailList('kotha@gmail.com'), AddressType('raujan', 'khulna', '127')),
  AttendanceRecordList(AttendanceRecordType(TO_DATE('2023-06-01', 'YYYY-MM-DD'), '01:00', '04:00')),
  ActivityLogList(ActivityLogType(TO_DATE('2023-06-01', 'YYYY-MM-DD'), 'Drawing')),
  '013',
  'CG003'
);

INSERT INTO child (
  child_id,
  name,
  age,
  contact_info,
  attendence_record,
  activity_log,
  parent_id,
  classgroup_id
) VALUES (
  'CH014',
  NameType('Mila', 'fabiha'),
  3,
  ContactInfoType(MobileNumberList('3457890123'), EmailList('mila@gmail.com'), AddressType('betbari', 'rangpur', '1217')),
  AttendanceRecordList(AttendanceRecordType(TO_DATE('2023-06-01', 'YYYY-MM-DD'), '09:00', '12:00')),
  ActivityLogList(ActivityLogType(TO_DATE('2023-06-01', 'YYYY-MM-DD'), 'Puzzles')),
  '014',
  'CG002'
);

INSERT INTO child (
  child_id,
  name,
  age,
  contact_info,
  attendence_record,
  activity_log,
  parent_id,
  classgroup_id
) VALUES (
  'CH015',
  NameType('shuvo', 'rahman'),
  4,
  ContactInfoType(MobileNumberList('4568901234'), EmailList('shuvo@gmail.com'), AddressType('meherpur', 'rajshahi', '1217')),
  AttendanceRecordList(AttendanceRecordType(TO_DATE('2023-06-01', 'YYYY-MM-DD'), '09:00', '12:00')),
  ActivityLogList(ActivityLogType(TO_DATE('2023-06-01', 'YYYY-MM-DD'), 'Outdoor Play')),
  '015',
  'CG002'
);
/

-- Insert data into staff table
INSERT INTO staff (
  staff_id,
  name,
  contact_info,
  role,
  qualifications,
  schedule,
  attendence_records,
  payroll_number,
  classgroup_id
) VALUES (
  'staff_001',
  NameType('atkeya', 'fahmida'),
  ContactInfoType(
    MobileNumberList('017345678967', '019345678967'),
    EmailList('atkeya@gmail.com'),
    AddressType('shantinagar', 'dhaka', '1217')
  ),
  'Teacher',
  'B.Ed',
  'Mon-Fri 8AM-4PM',
  AttendanceRecordList(AttendanceRecordType(DATE '2023-06-01', '08:00', '16:00')),
  'PR001',
  'CG001'
);

INSERT INTO staff (
  staff_id,
  name,
  contact_info,
  role,
  qualifications,
  schedule,
  attendence_records,
  payroll_number,
  classgroup_id
) VALUES (
  'staff_002',
  NameType('sanjida', 'sharmin'),
  ContactInfoType(
    MobileNumberList('0172233445', '01556677889'),
    EmailList('sanjida@gmail.com'),
    AddressType('malibagh', 'dhaka', '1217')
  ),
  'Assistant Teacher',
  'M.Ed',
  'Mon-Fri 9AM-5PM',
  AttendanceRecordList(AttendanceRecordType(DATE '2023-06-01', '09:00', '17:00')),
  'PR002',
  'CG002'
);

INSERT INTO staff (
  staff_id,
  name,
  contact_info,
  role,
  qualifications,
  schedule,
  attendence_records,
  payroll_number,
  classgroup_id
) VALUES (
  'staff_003',
  NameType('sumaiya', 'tabassum'),
  ContactInfoType(
    MobileNumberList('0223344556', '0667788990'),
    EmailList('sumaiya@gmail.com'),
    AddressType('kakrail', 'dhaka', '1217')
  ),
  'Teacher',
  'B.Sc',
  'Mon-Fri 8AM-4PM',
  AttendanceRecordList(AttendanceRecordType(DATE '2023-06-01', '09:00', '16:00')),
  'PR003',
  'CG003'
);

INSERT INTO staff (
  staff_id,
  name,
  contact_info,
  role,
  qualifications,
  schedule,
  attendence_records,
  payroll_number,
  classgroup_id
) VALUES (
  'staff_004',
  NameType('tasnia', 'malisa'),
  ContactInfoType(
    MobileNumberList('0174455667', '0198899001'),
    EmailList('tasnia@gmail.com'),
    AddressType('siddeswari', 'dhaka', '1214')
  ),
  'Caretaker',
  'Diploma in Childcare',
  'Mon-Fri 7AM-3PM',
  AttendanceRecordList(AttendanceRecordType(DATE '2023-06-01', '07:00', '15:00')),
  'PR004',
  'CG001'
);

INSERT INTO staff (
  staff_id,
  name,
  contact_info,
  role,
  qualifications,
  schedule,
  attendence_records,
  payroll_number,
  classgroup_id
) VALUES (
  'staff_005',
  NameType('sabira', 'karim'),
  ContactInfoType(
    MobileNumberList('01345566778', '01889900112','01589900112'),
    EmailList('sabira@gmail.com'),
    AddressType('dhanmondi', 'dhaka', '1518')
  ),
  'Teacher',
  'B.Ed',
  'Mon-Fri 8AM-4PM',
  AttendanceRecordList(AttendanceRecordType(DATE '2023-06-01', '08:00', '16:00')),
  'PR005',
  'CG002'
);

INSERT INTO staff (
  staff_id,
  name,
  contact_info,
  role,
  qualifications,
  schedule,
  attendence_records,
  payroll_number,
  classgroup_id
) VALUES (
  'staff_006',
  NameType('puja', 'sarker'),
  ContactInfoType(
    MobileNumberList('01556677889', '01990011223'),
    EmailList('puja@gmail.com', 'sarker@gmail.com' ),
    AddressType('shatora', 'cumilla', '112')
  ),
  'Assistant Teacher',
  'M.Ed',
  'Mon-Fri 9AM-5PM',
  AttendanceRecordList(AttendanceRecordType(DATE '2023-06-01', '09:00', '17:00')),
  'PR006',
  'CG003'
);

INSERT INTO staff (
  staff_id,
  name,
  contact_info,
  role,
  qualifications,
  schedule,
  attendence_records,
  payroll_number,
  classgroup_id
) VALUES (
  'staff_007',
  NameType('adiba', 'kabir'),
  ContactInfoType(
    MobileNumberList('01667788990', '01701122334'),
    EmailList('adiba@gmail.com'),
    AddressType('bagmara', 'cumilla', '123')
  ),
  'Teacher',
  'B.Sc',
  'Mon-Fri 8AM-4PM',
  AttendanceRecordList(AttendanceRecordType(DATE '2023-06-01', '08:00', '16:00')),
  'PR007',
  'CG001'
);

INSERT INTO staff (
  staff_id,
  name,
  contact_info,
  role,
  qualifications,
  schedule,
  attendence_records,
  payroll_number,
  classgroup_id
) VALUES (
  'staff_008',
  NameType('jasmin', 'akter'),
  ContactInfoType(
    MobileNumberList('01778899001', '01912233445'),
    EmailList('jasmin@gmail.com', 'akter@gmail.com'),
    AddressType('bijoypur', 'cumilla', '189')
  ),
  'Caretaker',
  'Diploma in Childcare',
  'Mon-Fri 7AM-3PM',
  AttendanceRecordList(AttendanceRecordType(DATE '2023-06-01', '07:00', '15:00')),
  'PR008',
  'CG002'
);

INSERT INTO staff (
  staff_id,
  name,
  contact_info,
  role,
  qualifications,
  schedule,
  attendence_records,
  payroll_number,
  classgroup_id
) VALUES (
  'staff_009',
  NameType('jessica', 'rafa'),
  ContactInfoType(
    MobileNumberList('01889900112', '01623344556'),
    EmailList('jessica@gmail.com'),
    AddressType('shilapara', 'cox bazar', '34')
  ),
  'Teacher',
  'B.Ed',
  'Mon-Fri 8AM-4PM',
  AttendanceRecordList(AttendanceRecordType(DATE '2023-06-01', '08:00', '16:00')),
  'PR009',
  'CG003'
);

INSERT INTO staff (
  staff_id,
  name,
  contact_info,
  role,
  qualifications,
  schedule,
  attendence_records,
  payroll_number,
  classgroup_id
) VALUES (
  'staff_010',
  NameType('rajani', 'farid'),
  ContactInfoType(
    MobileNumberList('01990011223', '01374455667'),
    EmailList('rajani@gmail.com'),
    AddressType('mohakhali', 'dhaka', '121')
  ),
  'Assistant Teacher',
  'M.Ed',
  'Mon-Fri 9AM-5PM',
  AttendanceRecordList(AttendanceRecordType(DATE '2023-06-01', '09:00', '17:00')),
  'PR010',
  'CG001'
);

INSERT INTO staff (
  staff_id,
  name,
  contact_info,
  role,
  qualifications,
  schedule,
  attendence_records,
  payroll_number,
  classgroup_id
) VALUES (
  'staff_011',
  NameType('nimra', 'haider'),
  ContactInfoType(
    MobileNumberList('01801122334', '01458566778'),
    EmailList('nimra@gmail.com'),
    AddressType('karnafuli', 'chittagong', '127')
  ),
  'Teacher',
  'B.Sc',
  'Mon-Fri 8AM-4PM',
  AttendanceRecordList(AttendanceRecordType(DATE '2023-06-01', '08:00', '16:00')),
  'PR011',
  'CG002'
);

INSERT INTO staff (
  staff_id,
  name,
  contact_info,
  role,
  qualifications,
  schedule,
  attendence_records,
  payroll_number,
  classgroup_id
) VALUES (
  'staff_012',
  NameType('tithi', 'rahman'),
  ContactInfoType(
    MobileNumberList('01712233445', '01596677889','01496677889'),
    EmailList('tithi@gmail.com'),
    AddressType('halishohor', 'chittagong', '117')
  ),
  'Caretaker',
  'Diploma in Childcare',
  'Mon-Fri 7AM-3PM',
  AttendanceRecordList(AttendanceRecordType(DATE '2023-06-01', '07:00', '15:00')),
  'PR012',
  'CG003'
);

INSERT INTO staff (
  staff_id,
  name,
  contact_info,
  role,
  qualifications,
  schedule,
  attendence_records,
  payroll_number,
  classgroup_id
) VALUES (
  'staff_013',
  NameType('payel', 'mim'),
  ContactInfoType(
    MobileNumberList('0123344556', '0167788990'),
    EmailList('payel@gmail.com','mim@gmail.com','payel56@gmail.com'),
    AddressType('raujan', 'khulna', '127')
  ),
  'Teacher',
  'B.Ed',
  'Mon-Fri 8AM-4PM',
  AttendanceRecordList(AttendanceRecordType(DATE '2023-06-01', '08:00', '16:00')),
  'PR013',
  'CG001'
);

INSERT INTO staff (
  staff_id,
  name,
  contact_info,
  role,
  qualifications,
  schedule,
  attendence_records,
  payroll_number,
  classgroup_id
) VALUES (
  'staff_014',
  NameType('sraboni', 'jahan'),
  ContactInfoType(
    MobileNumberList('0134455667', '0178899001','0194455667'),
    EmailList('sraboni@gmail.com'),
    AddressType('betbari', 'rangpur', '1217')
  ),
  'Assistant Teacher',
  'M.Ed',
  'Mon-Fri 9AM-5PM',
  AttendanceRecordList(AttendanceRecordType(DATE '2023-06-01', '09:00', '17:00')),
  'PR014',
  'CG002'
);

INSERT INTO staff (
  staff_id,
  name,
  contact_info,
  role,
  qualifications,
  schedule,
  attendence_records,
  payroll_number,
  classgroup_id
) VALUES (
  'staff_015',
  NameType('rupa', 'roy'),
  ContactInfoType(
    MobileNumberList('0145566778', '0189900112','0179900112'),
    EmailList('rupa@gmail.com'),
    AddressType('meherpur', 'rajshahi', '1217')
  ),
  'Teacher',
  'B.Sc',
  'Mon-Fri 8AM-4PM',
  AttendanceRecordList(AttendanceRecordType(DATE '2023-06-01', '08:00', '11:00'), AttendanceRecordType(DATE '2023-06-01', '13:00', '16:00')),
  'PR015',
  'CG003'
);

-- Inserting data into invoice table

INSERT INTO invoice (invoice_id, payment_details, child_id) 
VALUES ('INV001', PaymentDetailsType(150.00, DATE '2024-06-01', 'Paid'), 'CH001');

INSERT INTO invoice (invoice_id, payment_details, child_id) 
VALUES ('INV002', PaymentDetailsType(2000.00, DATE '2024-06-01', 'Pending'), 'CH002');

INSERT INTO invoice (invoice_id, payment_details, child_id) 
VALUES ('INV003', PaymentDetailsType(1750.00, DATE '2024-06-01', 'Paid'), 'CH003');

INSERT INTO invoice (invoice_id, payment_details, child_id) 
VALUES ('INV004', PaymentDetailsType(1800.00, DATE '2024-06-01', 'Pending'), 'CH004');

INSERT INTO invoice (invoice_id, payment_details, child_id) 
VALUES ('INV005', PaymentDetailsType(2100.00, DATE '2024-06-01', 'Paid'), 'CH005');

INSERT INTO invoice (invoice_id, payment_details, child_id) 
VALUES ('INV006', PaymentDetailsType(1600.00, DATE '2024-06-01', 'Pending'), 'CH006');

INSERT INTO invoice (invoice_id, payment_details, child_id) 
VALUES ('INV007', PaymentDetailsType(2200.00, DATE '2024-06-01', 'Paid'), 'CH007');

INSERT INTO invoice (invoice_id, payment_details, child_id) 
VALUES ('INV008', PaymentDetailsType(1950.00, DATE '2024-06-01', 'Pending'), 'CH008');

INSERT INTO invoice (invoice_id, payment_details, child_id) 
VALUES ('INV009', PaymentDetailsType(2050.00, DATE '2024-06-01', 'Paid'), 'CH009');

INSERT INTO invoice (invoice_id, payment_details, child_id) 
VALUES ('INV010', PaymentDetailsType(1850.00, DATE '2024-06-01', 'Pending'), 'CH010');

INSERT INTO invoice (invoice_id, payment_details, child_id) 
VALUES ('INV011', PaymentDetailsType(1550.00, DATE '2024-06-01', 'Paid'), 'CH011');

INSERT INTO invoice (invoice_id, payment_details, child_id) 
VALUES ('INV012', PaymentDetailsType(2300.00, DATE '2024-06-01', 'Pending'), 'CH012');

INSERT INTO invoice (invoice_id, payment_details, child_id) 
VALUES ('INV013', PaymentDetailsType(2400.00, DATE '2024-06-01', 'Paid'), 'CH013');

INSERT INTO invoice (invoice_id, payment_details, child_id) 
VALUES ('INV014', PaymentDetailsType(1700.00, DATE '2024-06-01', 'Pending'), 'CH014');

INSERT INTO invoice (invoice_id, payment_details, child_id) 
VALUES ('INV015', PaymentDetailsType(1900.00, DATE '2024-06-01', 'Paid'), 'CH015');

-- Inserting data into meal table
INSERT INTO meal (meal_id, type, serve_date, description, classgroup_id) 
VALUES ('MEAL001', 'Breakfast', DATE '2024-06-01', 'Pancakes, fruits, and milk', 'CG001');

INSERT INTO meal (meal_id, type, serve_date, description, classgroup_id) 
VALUES ('MEAL002', 'Lunch', DATE '2024-06-01', 'Chicken nuggets, vegetables, and juice', 'CG002');

INSERT INTO meal (meal_id, type, serve_date, description, classgroup_id) 
VALUES ('MEAL003', 'Snack', DATE '2024-06-01', 'Fruit salad and yogurt', 'CG003');

INSERT INTO meal (meal_id, type, serve_date, description, classgroup_id) 
VALUES ('MEAL004', 'Breakfast', DATE '2024-06-02', 'Cereal, fruits, and milk', 'CG004');

INSERT INTO meal (meal_id, type, serve_date, description, classgroup_id) 
VALUES ('MEAL005', 'Lunch', DATE '2024-06-02', 'Grilled cheese, tomato soup, and water', 'CG005');

INSERT INTO meal (meal_id, type, serve_date, description, classgroup_id) 
VALUES ('MEAL006', 'Snack', DATE '2024-06-02', 'Crackers and cheese', 'CG006');

INSERT INTO meal (meal_id, type, serve_date, description, classgroup_id) 
VALUES ('MEAL007', 'Breakfast', DATE '2024-06-03', 'Oatmeal, fruits, and milk', 'CG007');

INSERT INTO meal (meal_id, type, serve_date, description, classgroup_id) 
VALUES ('MEAL008', 'Lunch', DATE '2024-06-03', 'Turkey sandwich, vegetables, and juice', 'CG008');

INSERT INTO meal (meal_id, type, serve_date, description, classgroup_id) 
VALUES ('MEAL009', 'Snack', DATE '2024-06-03', 'Vegetable sticks and hummus', 'CG009');

INSERT INTO meal (meal_id, type, serve_date, description, classgroup_id) 
VALUES ('MEAL010', 'Breakfast', DATE '2024-06-04', 'Bagel, cream cheese, and milk', 'CG010');


-- Inserting data into activity table

INSERT INTO activity (activity_id, activity_date, name, description, classgroup_id) 
VALUES ('ACT001', DATE '2024-06-01', 'Story Time', 'Reading stories and discussing them', 'CG001');

INSERT INTO activity (activity_id, activity_date, name, description, classgroup_id) 
VALUES ('ACT002', DATE '2024-06-01', 'Art and Craft', 'Creating art with paints and papers', 'CG002');

INSERT INTO activity (activity_id, activity_date, name, description, classgroup_id) 
VALUES ('ACT003', DATE '2024-06-01', 'Outdoor Play', 'Playing games in the playground', 'CG003');

INSERT INTO activity (activity_id, activity_date, name, description, classgroup_id) 
VALUES ('ACT004', DATE '2024-06-02', 'Music Time', 'Singing songs and playing instruments', 'CG004');

INSERT INTO activity (activity_id, activity_date, name, description, classgroup_id) 
VALUES ('ACT005', DATE '2024-06-02', 'Cooking Class', 'Making simple snacks together', 'CG005');

INSERT INTO activity (activity_id, activity_date, name, description, classgroup_id) 
VALUES ('ACT006', DATE '2024-06-02', 'Gardening', 'Planting flowers and vegetables', 'CG006');

INSERT INTO activity (activity_id, activity_date, name, description, classgroup_id) 
VALUES ('ACT007', DATE '2024-06-03', 'Dance Party', 'Dancing to favorite tunes', 'CG007');

INSERT INTO activity (activity_id, activity_date, name, description, classgroup_id) 
VALUES ('ACT008', DATE '2024-06-03', 'Science Experiment', 'Fun experiments with everyday materials', 'CG008');

INSERT INTO activity (activity_id, activity_date, name, description, classgroup_id) 
VALUES ('ACT009', DATE '2024-06-03', 'Yoga Session', 'Relaxing yoga poses for kids', 'CG009');

INSERT INTO activity (activity_id, activity_date, name, description, classgroup_id) 
VALUES ('ACT010', DATE '2024-06-04', 'Puzzle Time', 'Solving puzzles and brain teasers', 'CG010');


-- Inserting data into medical_staff table
INSERT INTO medical_staff (medical_staff_id, name, qualifications, contact_info)
VALUES ('MS001', NameType('sanjana', 'khan'), 'Doctor', ContactInfoType(MobileNumberList('01234567890'), EmailList('sanjena@example.com'), AddressType('meherpur', 'rajshahi', '1217')));

INSERT INTO medical_staff (medical_staff_id, name, qualifications, contact_info)
VALUES ('MS002', NameType('mariyam', 'begum'), 'Nurse', ContactInfoType(MobileNumberList('019876543210'), EmailList('mariyam@example.com'), AddressType('betbari', 'rangpur', '1217')));

INSERT INTO medical_staff (medical_staff_id, name, qualifications, contact_info)
VALUES ('MS003', NameType('amena', 'khan'), 'Surgeon', ContactInfoType(MobileNumberList('015551234567'), EmailList('amena@example.com'), AddressType('raujan', 'khulna', '127')));

INSERT INTO medical_staff (medical_staff_id, name, qualifications, contact_info)
VALUES ('MS004', NameType('johirul', 'islam'), 'Pediatrician', ContactInfoType(MobileNumberList('013216549870'), EmailList('jahirul@example.com'), AddressType('halishohor', 'chittagong', '117')));
 
INSERT INTO medical_staff (medical_staff_id, name, qualifications, contact_info)
VALUES ('MS005', NameType('korobi', 'sarker'), 'Emergency Medicine Specialist', ContactInfoType(MobileNumberList('019870123456'), EmailList('korobi@example.com'), AddressType('karnafuli', 'chittagong', '127')));

INSERT INTO medical_staff (medical_staff_id, name, qualifications, contact_info)
VALUES ('MS006', NameType('arafat', 'sayed'), 'Anesthesiologist', ContactInfoType(MobileNumberList('014567890123'), EmailList('arafat@example.com'), AddressType('mohakhali', 'dhaka', '121')));

INSERT INTO medical_staff (medical_staff_id, name, qualifications, contact_info)
VALUES ('MS007', NameType('mamun', 'kabir'), 'Psychiatrist', ContactInfoType(MobileNumberList('017890123456'), EmailList('mamun@example.com'), AddressType('shilapara', 'cox bazar', '34')));

INSERT INTO medical_staff (medical_staff_id, name, qualifications, contact_info)
VALUES ('MS008', NameType('masud', 'ajgar'), 'Dentist', ContactInfoType(MobileNumberList('013698521470'), EmailList('masud@example.com'), AddressType('bijoypur', 'cumilla', '189')));

INSERT INTO medical_staff (medical_staff_id, name, qualifications, contact_info)
VALUES('MS009', NameType('kajol', 'roy'), 'Cardiologist', ContactInfoType(MobileNumberList('01593578524'), EmailList('kajol@example.com'), AddressType('bagmara', 'cumilla', '123')));

INSERT INTO medical_staff (medical_staff_id, name, qualifications, contact_info)
VALUES ('MS010', NameType('upoma', 'khan'), 'Neurologist', ContactInfoType(MobileNumberList('018523691470'), EmailList('upoma@example.com'), AddressType('shatora', 'cumilla', '112')));


--insert into event table
INSERT INTO event (event_id, event_date, name, description, classgroup_id)
VALUES ('EVT001', DATE '2024-06-01', 'Summer Picnic', 'A fun outdoor picnic for children and parents', 'CG001');

INSERT INTO event (event_id, event_date, name, description, classgroup_id)
VALUES ('EVT002', DATE '2024-06-05', 'Art Exhibition', 'Displaying artwork created by the children', 'CG002');

INSERT INTO event (event_id, event_date, name, description, classgroup_id)
VALUES ('EVT003', DATE '2024-06-10', 'Science Fair', 'Children present their science projects', 'CG003');

INSERT INTO event (event_id, event_date, name, description, classgroup_id)
VALUES ('EVT004', DATE '2024-06-15', 'Music Concert', 'Children perform various musical pieces', 'CG004');

INSERT INTO event (event_id, event_date, name, description, classgroup_id)
VALUES ('EVT005', DATE '2024-06-20', 'Sports Day', 'Outdoor sports activities and competitions', 'CG005');

INSERT INTO event (event_id, event_date, name, description, classgroup_id)
VALUES ('EVT006', DATE '2024-06-25', 'Drama Performance', 'Children present a play', 'CG006');

INSERT INTO event (event_id, event_date, name, description, classgroup_id)
VALUES ('EVT007', DATE '2024-06-30', 'Reading Marathon', 'A day dedicated to reading books', 'CG007');

INSERT INTO event (event_id, event_date, name, description, classgroup_id)
VALUES ('EVT008', DATE '2024-07-05', 'Cooking Workshop', 'Children learn to cook simple dishes', 'CG008');

INSERT INTO event (event_id, event_date, name, description, classgroup_id)
VALUES ('EVT009', DATE '2024-07-10', 'Gardening Day', 'Children plant and take care of a garden', 'CG009');

INSERT INTO event (event_id, event_date, name, description, classgroup_id)
VALUES ('EVT010', DATE '2024-07-15', 'Cultural Day', 'Celebrating different cultures and traditions', 'CG010');


-------------------Query 1----------------------------------------------------------
write sql query to find the name of those children and their payment details meal description whose parents city is dhaka.
------------------------------------------------------------------------------------
SELECT 
  c.name.first_name || ' ' || c.name.last_name AS child_name,
  i.payment_details.amount AS payment_amount,
  i.payment_details.due_date AS payment_due_date,
  i.payment_details.payment_status AS payment_status,
  m.description AS meal_description
FROM 
  child c
JOIN 
  parent p ON c.parent_id = p.parent_id
JOIN 
  invoice i ON c.child_id = i.child_id
JOIN 
  classgroup cg ON c.classgroup_id = cg.classgroup_id
JOIN 
  meal m ON cg.classgroup_id = m.classgroup_id
WHERE 
  p.contact_info.address.city = 'dhaka';


-----------------Query 2------------------
write sql query to retrieves children's names, their city, activity descriptions, and meal types for meals served in June 2024, specifically for those whose parents live in Dhaka
-------------------------------------------------------------

SELECT 
  c.name.first_name || ' ' || c.name.last_name AS child_name,
  c.contact_info.address.city AS city,
  c.age AS child_age,
  a.description AS activity_description,
  m.type AS meal_type
FROM 
  child c
JOIN 
  parent p ON c.parent_id = p.parent_id
JOIN 
  classgroup cg ON c.classgroup_id = cg.classgroup_id
JOIN 
  meal m ON cg.classgroup_id = m.classgroup_id
JOIN 
  TABLE(c.activity_log) a ON a.activity_date BETWEEN DATE '2023-06-01' AND DATE '2023-06-04'
WHERE 
  p.contact_info.address.city = 'dhaka'
  AND m.serve_date BETWEEN DATE '2024-06-01' AND DATE '2024-06-04';



-----------------Query 3------------------
Write an SQL query to retrieve the details of children younger than 5 years old who participated in activities on June 1, 2024, that contain the keyword 'ART' or 'art' in their description.
-------------------------------------------------------------
SELECT 
    c.child_id,
    c.name.first_name || ' ' || c.name.last_name AS child_name,
    c.age,
    a.activity_date,
    a.description AS activity_description
FROM 
    Child c
JOIN 
    ClassGroup cg ON c.classgroup_id = cg.classgroup_id
JOIN 
    activity a ON cg.classgroup_id = a.classgroup_id,
    TABLE(c.contact_info.mobile_numbers) t,
    TABLE(c.contact_info.emails) e
WHERE 
    c.age < 5 
    AND a.activity_date = TO_DATE('2024-06-01', 'YYYY-MM-DD') 
    AND (a.description LIKE '%ART%' OR a.description LIKE '%art%') 



-----------------Query 4------------------
Write an SQL query to retrieve the staff ID, full name, contact phone number, contact email, full address, role, qualifications, and schedule of staff members who hold the role of 'Teacher' and are assigned to the class group 'CG001'.
-------------------------------------------------------------

SELECT 
    s.staff_id,
    s.name.first_name,
    s.name.last_name,
    t_mobile.COLUMN_VALUE AS contact_phone,
    t_email.COLUMN_VALUE AS contact_email,
    s.contact_info.address.line || ', ' || s.contact_info.address.city || ', ' || s.contact_info.address.zip AS full_address,
    s.role,
    s.qualifications,
    s.schedule
FROM 
    staff s,
    TABLE(s.contact_info.mobile_numbers) t_mobile,
    TABLE(s.contact_info.emails) t_email
WHERE 
    s.classgroup_id = 'CG001' 
    AND s.role = 'Teacher' 

-----------------Query 5------------------
Write an SQL query to retrieve full name, contact phone number,full address,qualifications of medical staff members whose qualifications include 'Doctor' and whose phone numbers is grameen phone.
-------------------------------------------------------------
SELECT 
    ms.name.first_name || ' ' || ms.name.last_name AS medical_staff_name,
    ms.qualifications,
    t_mobile.COLUMN_VALUE AS contact_phone,
    ms.contact_info.address.line || ', ' || ms.contact_info.address.city || ', ' || ms.contact_info.address.zip AS full_address

FROM 
    medical_staff ms,
    TABLE(ms.contact_info.mobile_numbers) t_mobile
WHERE 
    ms.qualifications LIKE '%Doctor%'
    OR t_mobile.COLUMN_VALUE LIKE '017%'

-----------------Query 6------------------
write an sql query to find the event date, name, and description, along with the corresponding class group name, for events occurring between 5 July 2024, and 15 July 2024.
-------------------------------------------------------------
SELECT 
    e.event_date,
    e.name AS event_name,
    e.description AS event_description,
    c.name AS class_group_name
FROM 
    event e
JOIN 
    classgroup c ON e.classgroup_id = c.classgroup_id
WHERE 
    e.event_date BETWEEN TO_DATE('2024-07-05', 'YYYY-MM-DD') AND TO_DATE('2024-07-15', 'YYYY-MM-DD');

-----------------Query 7------------------
Retrieve the first name and last name of children, their class group age range, and details about activities they participated in where age range is 1-3 and 5-12 years
-------------------------------------------------------------

SELECT 
    c.name.first_name AS child_first_name,
    c.name.last_name AS child_last_name,
    cg.age_range,
    a.activity_date,
    a.name AS activity_name,
    a.description AS activity_description
FROM 
    child c
JOIN 
    classgroup cg ON c.classgroup_id = cg.classgroup_id
JOIN 
    activity a ON cg.classgroup_id = a.classgroup_id
WHERE 
    cg.age_range ='1-3 years' OR  cg.age_range ='5-12 years'



-----------------Query 8------------------
Write an SQL query to retrieve the names, schedules, qualifications, check-in times, and check-out times of all staff members who have either a 'Mon-Fri 7AM-3PM' or 'Mon-Fri 8AM-4PM'schedule.
-------------------------------------------------------------

SELECT 
    s.name.first_name || ' ' || s.name.last_name AS staff_name,
    s.schedule,
    s.qualifications,
    ar.check_in_time,
    ar.check_out_time
FROM 
    staff s,
    TABLE(s.attendence_records) ar
WHERE 
    s.schedule = 'Mon-Fri 7AM-3PM' OR  s.schedule = 'Mon-Fri 8AM-4PM'


-----------------Query 9------------------
Write an SQL query to retrieve the names, schedules, qualifications, check-in times, and check-out times of all staff members whose qualifications are B.SC or Diploma in child, and whose attendance records indicate they either checked in before 8 AM or checked out after 5 PM. 
-------------------------------------------------------------
SELECT 
    s.name.first_name || ' ' || s.name.last_name AS staff_name,
    s.schedule,
    s.qualifications,
    ar.check_in_time,
    ar.check_out_time
FROM 
    staff s,
    TABLE(s.attendence_records) ar
WHERE 
    (s.qualifications LIKE '%B.Sc%' OR s.qualifications LIKE '%Diploma%')
    AND (ar.check_in_time < '08:00' OR ar.check_out_time > '17:00');


-----------------Query 10------------------
Write an SQL query to retrieve details about children, their p
arents, events they participated in, and meals they were served. 
The query should only include children in the 'school aged' class group and filter events and meals served in the month of June 2024.
------------------------------------------------------------
SELECT
    c.name.first_name || ' ' || c.name.last_name AS child_name,
    p.name.first_name || ' ' || p.name.last_name AS parent_name,
    e.event_date,
    e.name AS event_name,
    e.description AS event_description,
    m.serve_date AS meal_date,
    m.type AS meal_type,
    m.description AS meal_description,
    cg.name AS class_group_name
FROM
    child c
JOIN
    parent p ON c.parent_id = p.parent_id
JOIN
    classgroup cg ON c.classgroup_id = cg.classgroup_id
JOIN
    event e ON cg.classgroup_id = e.classgroup_id
JOIN
    meal m ON cg.classgroup_id = m.classgroup_id
WHERE
    cg.name = 'school aged' 
    AND e.event_date BETWEEN TO_DATE('2024-06-01', 'YYYY-MM-DD') AND TO_DATE('2024-06-30', 'YYYY-MM-DD')
    AND m.serve_date BETWEEN TO_DATE('2024-06-01', 'YYYY-MM-DD') AND TO_DATE('2024-06-04', 'YYYY-MM-DD')
ORDER BY
    e.event_date, m.serve_date