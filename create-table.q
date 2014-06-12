-- USAGE: Mapping JSON from HDFS

CREATE EXTERNAL TABLE booking_propensity_logs (
  date_suite STRING,
  server_name STRING,
  class_method  STRING,
  message STRING,
  error_message STRING
) 
COMMENT 'External table. Contains log data from booking propensity MR jobs'
PARTITIONED BY (date_suite STRING)
ROW FORMAT SERDE 'com.cloudera.hive.serde.JSONSerDe'
LOCATION 'hdfs://xxxxxxxxxxxxxxxx:9000/data/XXXX-BOOKING-PROPENSITY-LOGS';

-- Load a whole hour data from HDFS
ALTER TABLE booking_propensity_logs ADD IF NOT EXISTS PARTITION (date_suite = ${hivevar:YEAR}${hivevar:MONTH}${hivevar:DAY}${hivevar:HOUR}) LOCATION 'hdfs://xxxxxxxxxxxxxxxxxx:9000/data/WDPRO-BOOKING-PROPENSITY-LOGS/${hivevar:YEAR}/${hivevar:MONTH}/${hivevar:DAY}/${hivevar:HOUR}/';

SHOW PARTITIONS booking_propensity_logs;
