SELECT personnel_contact.last_name + ', '
       + personnel_contact.first_name        AS [PI Name],
       study_rb_iacuc.iacuc_number           AS [IACUC Number],
       study.study_status                    AS [Study Status],
       study_rb_iacuc.iacuc_initial_approval AS [Initial Approval Date],
       study_rb_iacuc.iacuc_expiration       AS [Full Renewal Expiration Date],
       study.study_title                     AS [Study Title],
       study_definition.definition           AS [AAALAC Categories]
FROM   study_rb_iacuc
       INNER JOIN study
               ON study_rb_iacuc.system_study_id = study.system_study_id
       INNER JOIN study_access_personnel
               ON study.system_study_id = study_access_personnel.system_study_id
       INNER JOIN personnel_contact
               ON study_access_personnel.user_id = personnel_contact.user_id
       INNER JOIN study_definition
               ON study.system_study_id = study_definition.system_study_id
WHERE  ( study_access_personnel.primary_pi = N'yes' )
       AND ( study_definition.status = N'A' )
       AND ( study_definition.definition_type = N'2' ) 
