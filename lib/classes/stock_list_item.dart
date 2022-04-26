class StockListItem {
  final String papel;
  final String empresa;
  final String setor;
  final String subsetor;
  final int magicRanking;
  final int evByEbitRanking;
  final int roicRanking;
  final double cotacao;
  final double pByL;
  final double pByVp;
  final double psr;
  final double dividendYield;
  final double valorIntrinseco;
  final double pByAtivo;
  final double pByCapitalGiro;
  final double pByEbit;
  final double pByAtivoCircLiq;
  final double evByEbit;
  final double evByEbitda;
  final double margemEbit;
  final double margemLiq;
  final double liqCorr;
  final double roic;
  final double roe;
  final double liqDoisMeses;
  final double patrimonioLiquido;
  final double dividaBrutaByPatrimonio;
  final double crescRec;
  final String ultCotacao;
  final double numeroAcoes;
  final double ebit;
  final bool smallcap;
  final int magicValue;

  const StockListItem({
    required this.papel,
    required this.empresa,
    required this.cotacao,
    required this.pByL,
    required this.pByVp,
    required this.psr,
    required this.dividendYield,
    required this.pByAtivo,
    required this.pByCapitalGiro,
    required this.pByEbit,
    required this.pByAtivoCircLiq,
    required this.evByEbit,
    required this.evByEbitda,
    required this.margemEbit,
    required this.margemLiq,
    required this.liqCorr,
    required this.roic,
    required this.roe,
    required this.liqDoisMeses,
    required this.patrimonioLiquido,
    required this.dividaBrutaByPatrimonio,
    required this.crescRec,
    required this.subsetor,
    required this.setor,
    required this.ultCotacao,
    required this.numeroAcoes,
    required this.ebit,
    required this.smallcap,
    required this.evByEbitRanking,
    required this.roicRanking,
    required this.magicValue,
    required this.magicRanking,
    required this.valorIntrinseco,
  });

  factory StockListItem.fromJson(Map<String, dynamic> json) {
    return StockListItem(
      papel: json['papel'],
      empresa: json['empresa'],
      cotacao: json['cotacao'],
      pByL: json['pByL'],
      pByVp: json['pByVp'],
      psr: json['psr'],
      dividendYield: json['dividendYield'],
      pByAtivo: json['pByAtivo'],
      pByCapitalGiro: json['pByCapitalGiro'],
      pByEbit: json['pByEbit'],
      pByAtivoCircLiq: json['pByAtivoCircLiq'],
      evByEbit: json['evByEbit'],
      evByEbitda: json['evByEbitda'],
      margemEbit: json['margemEbit'],
      margemLiq: json['margemLiq'],
      liqCorr: json['liqCorr'],
      roic: json['roic'],
      roe: json['roe'],
      liqDoisMeses: json['liqDoisMeses'],
      patrimonioLiquido: json['patrimonioLiquido'],
      dividaBrutaByPatrimonio: json['dividaBrutaByPatrimonio'],
      crescRec: json['crescRec'],
      subsetor: json['subsetor'],
      setor: json['setor'],
      ultCotacao: json['ultCotacao'],
      numeroAcoes: json['numeroAcoes'],
      ebit: json['ebit'],
      smallcap: json['smallcap'],
      evByEbitRanking: json['evByEbitRanking'],
      roicRanking: json['roicRanking'],
      magicValue: json['magicValue'],
      magicRanking: json['magicRanking'],
      valorIntrinseco: json['valor_intrinseco'],
    );
  }

  Map toMap() {
    Map map = {};
    map['papel'] = papel;
    map['empresa'] = empresa;
    map['cotacao'] = cotacao;
    map['pByL'] = pByL;
    map['pByVp'] = pByVp;
    map['psr'] = psr;
    map['dividendYield'] = dividendYield;
    map['pByAtivo'] = pByAtivo;
    map['pByCapitalGiro'] = pByCapitalGiro;
    map['pByEbit'] = pByEbit;
    map['pByAtivoCircLiq'] = pByAtivoCircLiq;
    map['evByEbit'] = evByEbit;
    map['evByEbitda'] = evByEbitda;
    map['margemEbit'] = margemEbit;
    map['margemLiq'] = margemLiq;
    map['liqCorr'] = liqCorr;
    map['roic'] = roic;
    map['roe'] = roe;
    map['liqDoisMeses'] = liqDoisMeses;
    map['patrimonioLiquido'] = patrimonioLiquido;
    map['dividaBrutaByPatrimonio'] = dividaBrutaByPatrimonio;
    map['crescRec'] = crescRec;
    map['subsetor'] = subsetor;
    map['setor'] = setor;
    map['ultCotacao'] = ultCotacao;
    map['numeroAcoes'] = numeroAcoes;
    map['ebit'] = ebit;
    map['smallcap'] = smallcap;
    map['evByEbitRanking'] = evByEbitRanking;
    map['roicRanking'] = roicRanking;
    map['magicValue'] = magicValue;
    map['magicRanking'] = magicRanking;

    return map;
  }
}

const Map stockListLabelsMap = {
  "magicRanking": "Ranking",
  "papel": "Papel",
  "empresa": "Nome Empresa",
  "setor": "Setor",
  "subsetor": "Subsetor",
  "evByEbitRanking": "EV/EBIT Ranking",
  "roicRanking": "ROIC Ranking",
  "cotacao": "Cotação",
  "cotacaoToTop30": "Cotação para top 30",
  "pByL": "P/L",
  "pByVp": "P/VP",
  "psr": "PSR",
  "dividendYield": "Div.Yield",
  "pByAtivo": "P/Ativo",
  "pByCapitalGiro": "P/Cap.Giro",
  "pByEbit": "P/EBIT",
  "pByAtivoCircLiq": "P/Ativ Circ.Liq",
  "evByEbit": "EV/EBIT",
  "evByEbitda": "EV/EBITDA",
  "margemEbit": "Mrg Ebit",
  "margemLiq": "Mrg. Líq.",
  "liqCorr": "Liq. Corr.",
  "roic": "ROIC",
  "roe": "ROE",
  "liqDoisMeses": "Liq.2meses",
  "patrimonioLiquido": "Patrim. Líq",
  "dividaBrutaByPatrimonio": "Dív.Brut/ Patrim.",
  "crescRec": "Cresc. Rec.5a",
  "smallcap": "Smallcap",
  "valorIntrinseco": "Valor Intrínseco",
};
