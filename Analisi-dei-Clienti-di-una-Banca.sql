SELECT
  cli.id_cliente,
  year(current_date()) - year(cli.data_nascita) as eta,
  count(case when segno = '+' then 1 end) as n_entrate,
  count(case when segno = '-' then 1 end) as n_uscite,
  sum(case when segno = '+' then importo end) as entrate,
  sum(case when segno = '-' then importo end) as uscite,
  count(distinct cnt.id_conto) as n_conti,
  count(distinct cnt.id_conto, case when cnt.id_tipo_conto = 0 then 1 end) as conto_base,
  count(distinct cnt.id_conto, case when cnt.id_tipo_conto = 1 then 1 end) as conto_business,
  count(distinct cnt.id_conto, case when cnt.id_tipo_conto = 2 then 1 end) as conto_privati,
  count(distinct cnt.id_conto, case when cnt.id_tipo_conto = 3 then 1 end) as conto_famiglie,
  count(case when trn.id_tipo_trans = 3 then 1 end) as acq_amazon,
  count(case when trn.id_tipo_trans = 4 then 1 end) as mutuo,
  count(case when trn.id_tipo_trans = 5 then 1 end) as hotel,
  count(case when trn.id_tipo_trans = 6 then 1 end) as aereo,
  count(case when trn.id_tipo_trans = 7 then 1 end) as supermercato,
  count(case when trn.id_tipo_trans = 0 then 1 end) as stipendio,
  count(case when trn.id_tipo_trans = 1 then 1 end) as pensione,
  count(case when trn.id_tipo_trans = 2 then 1 end) as dividendi,
  sum(case when cnt.id_tipo_conto = 0 and segno = '-' then importo end) as spese_conto_base,
  sum(case when cnt.id_tipo_conto = 1 and segno = '-' then importo end) as spese_conto_business,
  sum(case when cnt.id_tipo_conto = 2 and segno = '-' then importo end) as spese_conto_privati,
  sum(case when cnt.id_tipo_conto = 3 and segno = '-' then importo end) as spese_conto_famiglie,
  sum(case when cnt.id_tipo_conto = 0 and segno = '+' then importo end) as entrate_conto_base,
  sum(case when cnt.id_tipo_conto = 1 and segno = '+' then importo end) as entrate_conto_business,
  sum(case when cnt.id_tipo_conto = 2 and segno = '+' then importo end) as entrate_conto_privati,
  sum(case when cnt.id_tipo_conto = 3 and segno = '+' then importo end) as entrate_conto_famiglie
FROM
  banca.cliente cli
  inner join banca.conto cnt on cli.id_cliente = cnt.id_cliente
  inner join banca.transazioni trn on cnt.id_conto = trn.id_conto
  inner join banca.tipo_transazione ttrn on trn.id_tipo_trans = ttrn.id_tipo_transazione
group by
  1;

