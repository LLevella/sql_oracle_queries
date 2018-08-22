create or replace function str_duplicate_delete_and_order2 
    (str_in in varchar2)
    return varchar2
 is
    varchar2 str_out;
    
    cursor curs_tmp is
        with table_tmp as ( select str_in as str_in_tmp from dual)
        select listagg(str_elem, ';') WITHIN GROUP (ORDER BY str_elem)
        from (
        select distinct regexp_substr(str_in_tmp, '[^;]+', 1, level) str_elem from table_tmp
        connect by regexp_substr(str_in_tmp, '[^;]+', 1, level)  is not null
       );
begin
  open curs_tmp;
  fetch curs_tmp into str_out;
 
  if curs_tmp%notfound then
      str_out := '';
  end if;
 
  close curs_tmp;
  return str_out;

end;

