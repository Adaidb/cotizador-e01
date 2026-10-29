export type Puente = 'comercio_mundial' | 'colombia';

export type Carga =
  | { tipo: 'general' }
  | { tipo: 'refrigerada' }
  | { tipo: 'peligrosa'; numeroUn: string }
  | { tipo: 'sobredimensionada'; permiso: string };

export type Embarque = {
  id: string;
  pesoKg: number;
  distanciaKm: number;
  puente: Puente;
} & Carga;

export type Cotizacion = {
  id: string;
  fleteBruto: number;
  descuento: number;
  flete: number;
  cuotaPuente: number;
  recargo: number;
  ajusteMinimo: number;
  total: number;
};

export type Motivo = 'peso_invalido' | 'distancia_invalida' | 'excede_peso_maximo';

export type Reglas = {
  tarifaKm: number;
  cuotaPuente: Record<Puente, number>;
  descuento: {
    umbralKg: number;
    pct: number;
    criterio: 'a_partir_de' | 'mas_de';
  };
  recargo: Record<Carga['tipo'], { pct: number; fija: number }>;
  baseRecargo: 'flete' | 'subtotal';
  minimo: number;
  pesoMaximoKg: number;
};

export type Borrador = {
  estado: 'borrador';
  embarque: Embarque;
};

export type Cotizado = {
  estado: 'cotizado';
  embarque: Embarque;
  cotizacion: Cotizacion;
};

export type Rechazado = {
  estado: 'rechazado';
  motivo: Motivo;
};

export type Despachado = {
  estado: 'despachado';
  embarque: Embarque;
  cotizacion: Cotizacion;
  folio: string;
};

export type Resultado<T, E> = T | E;

const politicasPesoMaximo: Record<Carga['tipo'], (peso: number, max: number) => boolean> = {
  general: (peso, max) => peso <= max,
  refrigerada: (peso, max) => peso <= max,
  peligrosa: (peso, max) => peso <= max,
  sobredimensionada: () => true,
};

export function cotizar(b: Borrador, r: Reglas): Resultado<Cotizado, Rechazado> {
  const emb = b.embarque;

  if (emb.pesoKg <= 0) {
    return { estado: 'rechazado', motivo: 'peso_invalido' };
  }
  if (emb.distanciaKm <= 0) {
    return { estado: 'rechazado', motivo: 'distancia_invalida' };
  }
  
  const cumplePeso = politicasPesoMaximo[emb.tipo](emb.pesoKg, r.pesoMaximoKg);
  if (!cumplePeso) {
    return { estado: 'rechazado', motivo: 'excede_peso_maximo' };
  }

  const fleteBruto = emb.distanciaKm * r.tarifaKm;

  let aplicaDescuento = false;
  if (r.descuento.criterio === 'a_partir_de') {
    aplicaDescuento = emb.pesoKg >= r.descuento.umbralKg;
  } else if (r.descuento.criterio === 'mas_de') {
    aplicaDescuento = emb.pesoKg > r.descuento.umbralKg;
  }

  const descuento = aplicaDescuento ? Math.floor((fleteBruto * r.descuento.pct + 50) / 100) : 0;
  const flete = fleteBruto - descuento;
  const cuotaPuente = r.cuotaPuente[emb.puente];

  const recargoReglas = r.recargo[emb.tipo];
  const baseCalc = r.baseRecargo === 'subtotal' ? flete + cuotaPuente : flete;
  const recargo = Math.floor((baseCalc * recargoReglas.pct + 50) / 100) + recargoReglas.fija;

  const subtotalConRecargo = flete + cuotaPuente + recargo;
  const total = Math.max(subtotalConRecargo, r.minimo);
  const ajusteMinimo = total - subtotalConRecargo;

  const cotizacion: Cotizacion = {
    id: emb.id,
    fleteBruto,
    descuento,
    flete,
    cuotaPuente,
    recargo,
    ajusteMinimo,
    total,
  };

  return {
    estado: 'cotizado',
    embarque: emb,
    cotizacion,
  };
}