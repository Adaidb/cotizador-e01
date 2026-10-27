export type Ajuste = (monto: number) => number;

const pct = (monto: number, p: number): number => Math.floor((monto * p + 50) / 100);

// 1 · Los tres extras. Una línea cada uno.
export const frio: Ajuste = (monto) => monto + pct(monto, 18);

export const seguro: Ajuste = (monto) => monto + pct(monto, 2);

export const express: Ajuste = (monto) => monto + 50000; // 50000 centavos ($500.00)

// 2 · El flete (km × tarifa) 
export function cotizar(km: number, tarifaKm: number, ajustes: readonly Ajuste[]): number {
  return ajustes.reduce((monto, ajuste) => ajuste(monto), km * tarifaKm);
}

void pct;