--Name changes
--moved to https://github.com/OHDSI/Vocabulary-v5.0/blob/968a4f20086da72980864672c9fdad70a587b627/working/manual_checks_after_generic.sql#L26
--contents of brackets are no longer lost, leading to way less duplication
--Prefer US spelling over UK
--Better overall
;
--Validity dates changes
select c.concept_code, c.concept_name, c2.valid_start_date as old_start, c2.valid_end_date as old_end, c.valid_start_date as new_start, c.valid_end_date as new_end
from concept c
join devv5.concept c2 using (concept_id)
where 
	c.invalid_reason is not null and
	c2.invalid_reason is not null and
	(c.valid_start_date, c.valid_end_date) != (c2.valid_start_date, c2.valid_end_date)
limit 1000
--dates better correspond to source values rathher then our release cycles
--150 000 rows in full list
;
--domain changes for active concepts
select c1.concept_code,c1.concept_name, c1.concept_class_id, c1.invalid_reason, c2.domain_id as old, c1.domain_id as new
from concept c1
join devv5.concept c2 on
	(c1.vocabulary_id, c1.concept_code) = (c2.vocabulary_id, c2.concept_code) and
	c1.domain_id != c2.domain_id and
	c1.invalid_reason is null
order by c1.domain_id, c2.domain_id
--Mostly due to new added peaks; some changes are caused by hierarchy changes
--Units lost their domains because UK hierarchy is broken; will fix itself next release cycle
;
--domain changes for inactive concepts
select c1.concept_code,c1.concept_name, c1.invalid_reason, c2.domain_id as old, c1.domain_id as new
from concept c1
join devv5.concept c2 on
	(c1.vocabulary_id, c1.concept_code) = (c2.vocabulary_id, c2.concept_code) and
	c1.domain_id != c2.domain_id and
	c1.invalid_reason is not null
order by c1.domain_id, c2.domain_id
--now inherit domain from map target
;
--New invalid concepts class stats
select c1.concept_class_id, count (1)
from concept c1
left join devv5.concept c2 on
	(c1.vocabulary_id, c1.concept_code) = (c2.vocabulary_id, c2.concept_code)
where c2.concept_id is null and
	c1.invalid_reason is not null
group by c1.concept_class_id
--New invalid concepts are created because of new extraction logic, which no longer ignores them
--Concepts that don't have a name with a hierarchy tag (and whose hierarchy is long gone) get Context-dependent class
--Some are Undefined; but no active concepts are undefined
;
--New active concepts; no dsicernible problems
select c1.*
from concept c1
left join devv5.concept c2 on
	(c1.vocabulary_id, c1.concept_code) = (c2.vocabulary_id, c2.concept_code)
where c2.concept_id is null and
	c1.invalid_reason is null
;
--New logic for Numbers and Letters, making them Measurement Values: complete overview
select c.concept_code, c.concept_name, c2.domain_id as old, c.domain_id as new
from devv5.concept_ancestor a --new concept ancestor is not yet built
join devv5.concept c2 on
	a.ancestor_concept_id in (4126548,4156064) and --Number, Alphanumeric
	a.descendant_concept_id = c2.concept_id and
	c2.vocabulary_id = 'SNOMED'
join concept c on
	(c.vocabulary_id, c.concept_code) = (c2.vocabulary_id, c2.concept_code) and
	c.domain_id != c2.domain_id
where c.invalid_reason is null
;
--New covid concepts and their mappings (All UK -- US changes were already managed by SNOMED US)
select c.concept_code, c.concept_name, c.standard_concept, r.relationship_id, c2.concept_code, c2.vocabulary_id, c2.concept_name, c2.standard_concept, r.valid_start_date
from concept c
join concept_relationship r on
	r.concept_id_1 = c.concept_id and
	r.relationship_id in ('Maps to', 'Maps to value', 'Is a') AND r.invalid_reason IS NULL
join concept c2 on
	c2.concept_id = r.concept_id_2
where
	c.vocabulary_id = 'SNOMED' and (
	c.concept_code in
	(
		'1321241000000105','1321701000000102','1321661000000108',
		'1321701000000102','1321661000000108','1322901000000109',
		'1322891000000108','1322871000000109','1322911000000106',
		'1322801000000101','1322791000000100','1322781000000102',
		'1322821000000105','1321771000000105','1322841000000103',
		'1321791000000109','1321761000000103','1321781000000107',
		'1321591000000103','1322831000000107','1321571000000102',
		'1321541000000108','1321641000000107','1321631000000103',
		'1322851000000100','1321561000000109','1321551000000106',
		'1321581000000100','1322901000000109','1322891000000108',
		'1322871000000109','1322911000000106','1322801000000101',
		'1322791000000100','1322781000000102','1322821000000105',
		'1321771000000105','1322841000000103','1321791000000109',
		'1321761000000103','1321781000000107','1321591000000103',
		'1322831000000107','1321571000000102','1321541000000108',
		'1321641000000107','1321631000000103','1322851000000100',
		'1321561000000109','1321551000000106','1321581000000100',
		'1321621000000100','1321651000000105','1321681000000104',
		'1321691000000102','1321621000000100','1321651000000105',
		'1321681000000104','1321691000000102','1321821000000104',
		'1321801000000108','1321811000000105','1321341000000103',
		'1321321000000105','1321351000000100','1321311000000104',
		'1321301000000101','1321741000000104','1321721000000106',
		'1321731000000108','1321711000000100','1321291000000100',
'840533007',
'840534001',
'840535000',
'840536004',
'840539006',
'840544004',
'840546002',
'866151004',
'866152006',
'870361009',
'870362002',
'870577009',
'870588003',
'870589006',
'870590002',
'870591003',
'871552002',
'871553007',
'871555000',
'871556004',
'871557008',
'871558003',
'871559006',
'871560001',
'871562009',
'871810001',
'895231008',
'897034005',
'897035006',
'897036007',
'1017214008',
'1119302008',
'1119303003',
'1119304009',
'1119305005',
'1119349007',
'1119350007',
'1142178009',
'1142180003',
'1142181004',
'1142182006',
'1144997007',
'1144998002',
'1145003007',
'1145022003',
'1145023008',
'1145026000',
'1145028004',
'1145029007',
'1145030002',
'1145031003',
'1145032005',
'1145033000',
'1145034006',
'1145035007',
'119731000146105',
'119741000146102',
'119751000146104',
'119981000146107',
'461911000124106',
'829831000000100',
'1240411000000107',
'1240461000000109',
'1240471000000102',
'1240521000000100',
'1240531000000103',
'1240541000000107',
'1240561000000108',
'1240581000000104',
'1240591000000102',
'138389411000119105',
'189486241000119100',
'292508471000119105',
'674814021000119106',
'688232241000119100',
'880529761000119102',
'882784691000119100'
	)
	    OR (c.concept_name ~* 'covid|Severe acute respiratory syndrome coronavirus|SARS-CoV'
	        AND
	        c.concept_name !~* 'Covidien')


	    )
;

--All new peaks and their changed descendants
select p.concept_code as peak_code,
       p.concept_name as peak_name,
       c1.concept_code,
       c1.concept_name,
       c1.invalid_reason,
       c2.domain_id as old,
       c1.domain_id as new
from concept c1
join devv5.concept c2 on
	(c1.vocabulary_id, c1.concept_code) = (c2.vocabulary_id, c2.concept_code) and
	c1.domain_id != c2.domain_id and
	c1.invalid_reason is null
join concept p on
	p.vocabulary_id = 'SNOMED' and
	p.concept_code :: int8 in (SELECT peak_code FROM peak WHERE
	                                                            valid_start_date > to_date ('20201101', 'YYYYMMDD') --peaks introduced in the recent refresh
	                                                        AND valid_end_date = to_date('20991231', 'YYYYMMDD'))   --active peaks
join snomed_ancestor a on
	p.concept_code = a.ancestor_concept_code::varchar and
	c2.concept_code = a.descendant_concept_code::varchar
order by p.concept_name, c1.domain_id, c2.domain_id
;