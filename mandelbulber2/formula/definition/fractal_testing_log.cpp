﻿/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.         ______
 * Copyright (C) 2020 Mandelbulber Team   _>]|=||i=i<,      / ____/ __    __
 *                                        \><||i|=>>%)     / /   __/ /___/ /_
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    / /__ /_  __/_  __/
 * The project is licensed under GPLv3,   -<>>=|><|||`    \____/ /_/   /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * t
 */

#include "all_fractal_definitions.h"

cFractalTestingLog::cFractalTestingLog() : cAbstractFractal()
{
	nameInComboBox = "Testing Log";
	internalName = "testing_log";
	internalID = fractal::testingLog;
	DEType = analyticDEType;
	DEFunctionType = logarithmicDEFunction;
	cpixelAddition = cpixelDisabledByDefault;
	defaultBailout = 10.0;
	DEAnalyticFunction = analyticFunctionLogarithmic;
	coloringFunction = coloringFunctionDefault;
}

void cFractalTestingLog::FormulaCode(CVector4 &z, const sFractal *fractal, sExtendedAux &aux)
{

		// Preparation operations
		double fac_eff = 0.6666666666;
		double offset = 0.0;//1.0e-17;
		CVector4 Solution = fractal->transformCommon.offset100;

		if (fractal->transformCommon.functionEnabledAFalse)
		{
			if (fractal->transformCommon.functionEnabledAxFalse) z.x = fabs(z.x);
			if (fractal->transformCommon.functionEnabledAyFalse) z.y = fabs(z.y);
			if (fractal->transformCommon.functionEnabledAzFalse) z.z = fabs(z.z);
		}
		CVector4 c;

		c = CVector4(fractal->transformCommon.scaleNeg1,
				fractal->transformCommon.offsetA0,
				fractal->transformCommon.offsetB0,
				0.0); //temppppppppppp

		/*if (aux.i < fractal->transformCommon.stopIterations1)
		{
			if (fractal->transformCommon.juliaMode)
			{
				 c = CVector4(fractal->transformCommon.scaleNeg1,
						fractal->transformCommon.offsetA0,
						 fractal->transformCommon.offsetB0,
						 0.0); //temppppppppppp
			 }
			else
			{
				//if (!fractal->transformCommon.functionEnabledCFalse) c = aux.const_c;
				//else c = z;
				c = z * fractal->transformCommon.vec111;
				//c *= fractal->transformCommon.constantMultiplier100;
			}
		}*/

	// Converting the diverging (x,y,z) back to the variable
	// that can be used for the (converging) Newton method calculation
		double sq_r = fractal->transformCommon.scaleA1 / (aux.r * aux.r + offset);
		z.x = z.x * sq_r + Solution.x;
		z.y = -z.y * sq_r + Solution.y; // 0.0
		z.z = -z.z * sq_r + Solution.z; // 0.0

	// Calculate the inverse power of t=(x,y,z),
	// and use it for the Newton method calculations for t^power + c = 0
	// i.e. t(n+1) = 2*t(n)/3 - c/2*t(n)^2
		CVector4 tp = z * z;
		sq_r = tp.x + tp.y + tp.z; // dot
		sq_r = 1.0 / (3.0 * sq_r * sq_r + offset);
		double r_xy = tp.x + tp.y;
		double h1 = 1.0 - tp.z / r_xy;

		double tmpx = h1 * (tp.x - tp.y) * sq_r;
		double tmpy = -2.0 * h1 * z.x * z.y * sq_r;
		double tmpz = 2.0 * z.z * sqrt(r_xy) * sq_r;

		double r_2xy = sqrt(tmpx * tmpx + tmpy * tmpy);
		double r_2cxy = sqrt(c.x * c.x + c.y * c.y);
		double h = 1.0 - c.z * tmpz / (r_2xy * r_2cxy);

		tp.x = (c.x * tmpx - c.y * tmpy) * h;
		tp.y = (c.y * tmpx + c.x * tmpy) * h;
		tp.z = r_2cxy * tmpz + r_2xy * c.z;

		z = fac_eff * z - tp;

	// Below the hack that provides a divergent value of (x,y,z) to Mandelbulber
	// although the plain Newton method does always converge
		tp = z - Solution;
		sq_r = fractal->transformCommon.scaleB1 / (tp.Dot(tp) + offset);
		z.x = tp.x * sq_r;
		z.y = -tp.y * sq_r;
		z.z = -tp.z * sq_r;
		aux.DE = aux.DE * aux.r * 2.0;

		if (fractal->analyticDE.enabledFalse)
		{
			aux.DE = aux.DE * fractal->analyticDE.scale1 + fractal->analyticDE.offset1;
		}
	double r = z.Length();
	aux.dist = 0.5 * log(r) * r / aux.DE;

	/*double dd = z.Length() / aux.r;
	dd = dd + (aux.r * 2.0 - dd) * fractal->transformCommon.scale1;
	aux.DE *= dd;*/



}
