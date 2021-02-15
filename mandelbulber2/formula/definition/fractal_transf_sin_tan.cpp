/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.         ______
 * Copyright (C) 2020 Mandelbulber Team   _>]|=||i=i<,      / ____/ __    __
 *                                        \><||i|=>>%)     / /   __/ /___/ /_
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    / /__ /_  __/_  __/
 * The project is licensed under GPLv3,   -<>>=|><|||`    \____/ /_/   /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *

 */

#include "all_fractal_definitions.h"

cFractalTransfSinTan::cFractalTransfSinTan() : cAbstractFractal()
{
	nameInComboBox = "T>Sin Tan";
	internalName = "transf_sin_tan";
	internalID = fractal::transfSinTan;
	DEType = analyticDEType;
	DEFunctionType = withoutDEFunction;
	cpixelAddition = cpixelDisabledByDefault;
	defaultBailout = 100.0;
	DEAnalyticFunction = analyticFunctionNone;
	coloringFunction = coloringFunctionDefault;
}

void cFractalTransfSinTan::FormulaCode(CVector4 &z, const sFractal *fractal, sExtendedAux &aux)
{
	CVector4 v;
	switch (fractal->mandelbulbMulti.orderOfXYZ)
	{
		case multi_OrderOfXYZ_xyz:
		default: v = CVector4(z.x, z.y, z.z, z.w); break;
		case multi_OrderOfXYZ_xzy: v = CVector4(z.x, z.z, z.y, z.w); break;
		case multi_OrderOfXYZ_yxz: v = CVector4(z.y, z.x, z.z, z.w); break;
		case multi_OrderOfXYZ_yzx: v = CVector4(z.y, z.z, z.x, z.w); break;
		case multi_OrderOfXYZ_zxy: v = CVector4(z.z, z.x, z.y, z.w); break;
		case multi_OrderOfXYZ_zyx: v = CVector4(z.z, z.y, z.x, z.w); break;
	}
	if (fractal->transformCommon.functionEnabledAx)
		z.x = tan(sin((v.x - fractal->transformCommon.offset000.x) * fractal->transformCommon.constantMultiplierA111.x))
				* fractal->transformCommon.constantMultiplierB111.x + fractal->transformCommon.offsetA000.x;
	if (fractal->transformCommon.functionEnabledAyFalse)
		z.y = tan(sin((v.y - fractal->transformCommon.offset000.y) * fractal->transformCommon.constantMultiplierA111.y))
				* fractal->transformCommon.constantMultiplierB111.y + fractal->transformCommon.offsetA000.y;
	if (fractal->transformCommon.functionEnabledAzFalse)
		z.z = tan(sin((v.z - fractal->transformCommon.offset000.z) * fractal->transformCommon.constantMultiplierA111.z))
				* fractal->transformCommon.constantMultiplierB111.z + fractal->transformCommon.offsetA000.z;

	// DE tweak
	if (fractal->analyticDE.enabledFalse)
		aux.DE = aux.DE * fractal->analyticDE.scale1 + fractal->analyticDE.offset0;
}
