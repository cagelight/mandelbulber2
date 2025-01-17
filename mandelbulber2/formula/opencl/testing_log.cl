/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2021 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * trafassel
 *
 https://fractalforums.org/fractal-mathematics-and-new-theories/28/fake-3d-mandelbrot-set/1787/msg17956#msg17956

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_testing_log.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 TestingLogIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{

// Preparation operations
	REAL fac_eff = 0.6666666666;
	REAL offset = 1.0e-10;
	REAL4 Solution = fractal->transformCommon.offset100;


	// abs transforms
	if (fractal->transformCommon.functionEnabledAFalse)
	{
		if (fractal->transformCommon.functionEnabledAxFalse) z.x = fabs(z.x);
		if (fractal->transformCommon.functionEnabledAyFalse) z.y = fabs(z.y);
		if (fractal->transformCommon.functionEnabledAzFalse) z.z = fabs(z.z);
	}
	REAL4 c;

	c = (REAL4){fractal->transformCommon.scaleNeg1,
		   fractal->transformCommon.offsetA0,
			fractal->transformCommon.offsetB0,
			0.0f}; //temppppppppppp

	/*if (aux->i < fractal->transformCommon.stopIterations1)
	{
		if (fractal->transformCommon.juliaMode)
		{
			 c = (REAL4){fractal->transformCommon.scaleNeg1,
					fractal->transformCommon.offsetA0,
					 fractal->transformCommon.offsetB0,
					 0.0f}; //temppppppppppp
		 }
		else
		{
			//if (!fractal->transformCommon.functionEnabledCFalse) c = aux->const_c;
			//else c = z;
			c = aux->const_c * fractal->transformCommon.vec111;
			//c *= fractal->transformCommon.constantMultiplier100;
		}
	}*/

// Converting the diverging (x,y,z) back to the variable
// that can be used for the (converging) Newton method calculation
	REAL sq_r = fractal->transformCommon.scaleA1 / (aux->r * aux->r + offset);
	z.x = z.x * sq_r + Solution.x;
	z.y = -z.y * sq_r + Solution.y; // 0.0
	z.z = -z.z * sq_r + Solution.z; // 0.0

// Calculate the inverse power of t=(x,y,z),
// and use it for the Newton method calculations for t^power + c = 0
// i.e. t(n+1) = 2*t(n)/3 - c/2*t(n)^2
	REAL4 tp = z * z;
	sq_r = tp.x + tp.y + tp.z;
	sq_r = 1.0f / (3.0f * sq_r * sq_r + offset);
	REAL r_xy = tp.x + tp.y;
	REAL h1 = 1.0f - tp.z / r_xy;

	REAL tmpx = h1 * (tp.x - tp.y) * sq_r;
	REAL tmpy = -2.0f * h1 * z.x * z.y * sq_r;
	REAL tmpz = 2.0f * z.z * native_sqrt(r_xy) * sq_r;

	REAL r_2xy = native_sqrt(tmpx * tmpx + tmpy * tmpy);
	REAL r_2cxy = native_sqrt(c.x * c.x + c.y * c.y);
	REAL h = 1.0f - c.z * tmpz / (r_2xy * r_2cxy);

	tp.x = (c.x * tmpx - c.y * tmpy) * h;
	tp.y = (c.y * tmpx + c.x * tmpy) * h;
	tp.z = r_2cxy * tmpz + r_2xy * c.z;

	z = fac_eff * z - tp;


// Below the hack that provides a divergent value of (x,y,z) to Mandelbulber
// although the plain Newton method does always converge

	tp = z - Solution;

	sq_r = fractal->transformCommon.scaleB1 / (dot(tp, tp) + offset);
	z.x = tp.x * sq_r;
	z.y = -tp.y * sq_r;
	z.z = -tp.z * sq_r;

	aux->DE = aux->DE * aux->r * 2.0f;

	if (fractal->analyticDE.enabledFalse)
	{
		aux->DE = aux->DE * fractal->analyticDE.scale1 + fractal->analyticDE.offset1;
	}




	/*REAL r, r1, dr, theta, phi, r_pow, theta_pow, phi_pow,  cth, cph, sph, sth, tmpx, tmpy, tmpz, tmpx2, tmpy2, tmpz2, r_zxy, r_cxy, h, scale;
	REAL Factor_Phi = 1.0f;
	REAL Factor_Theta = 1.0f;
	//aux->DE = aux->DE * aux->r * 2.0f;

	// Preparation operations

	REAL Power = fractal->transformCommon.pwr8 + 1.0f;
	REAL fac_eff = (Power - 1.0) / Power;
	REAL pow_eff = 1.0 - Power;

	REAL4 Solution = fractal->transformCommon.offset100;
	REAL Offset = 1.0e-10f;

	REAL4 c;
	if (aux->i < fractal->transformCommon.stopIterations1)
	{
		if (fractal->transformCommon.juliaMode)
		{
			 c = (REAL4){fractal->transformCommon.scaleNeg1,
					fractal->transformCommon.offsetA0,
					 fractal->transformCommon.offsetB0,
					 0.0f}; //temppppppppppp
		 }
		else
		{
			//if (!fractal->transformCommon.functionEnabledCFalse) c = aux->const_c;
			//else c = z;
			c = aux->const_c * fractal->transformCommon.vec111;
			//c *= fractal->transformCommon.constantMultiplier100;
		}
	}

	if (fractal->transformCommon.functionEnabledAFalse)
	{
		if (fractal->transformCommon.functionEnabledAxFalse) z.x = fabs(z.x);
		if (fractal->transformCommon.functionEnabledAyFalse) z.y = fabs(z.y);
		if (fractal->transformCommon.functionEnabledAzFalse) z.z = fabs(z.z);
	}



	// Converting the diverging (x,y,z) back to the variable
	// that can be used for the (converging) Newton method calculation
	REAL sq_r = fractal->transformCommon.scale / (dot(z, z) + Offset);
	z.x = z.x * sq_r + Solution.x;
	z.y = -z.y * sq_r + Solution.y;
	z.z = -z.z * sq_r + Solution.z;

	// Calculate 1/z^(power-1)
	sq_r = dot(z,z);
	r = sqrt(sq_r);
	phi = Factor_Phi * asin(z.z / r);
	theta = Factor_Theta * atan2(z.y, z.x);

	r_pow = pow(r, pow_eff);
	//r_pow *= r; // mmmmmmmmmmmmmmmmmmmmmmmm
	//aux->DE = (r_pow * aux->DE) * pow_eff + 1.0f; // mmmmmmmmmmmmmmmmmmmmm


	phi_pow = phi * pow_eff;
	theta_pow = theta * pow_eff;

	cth = cos(theta_pow);
	sth = sin(theta_pow);
	cph = cos(phi_pow);
	sph = sin(phi_pow);

	tmpx = -cph * cth * r_pow  /Power;
	tmpy = -cph * sth * r_pow / Power;
	tmpz = sph * r_pow / Power;

	// Multiply c and z
	r_zxy = sqrt(tmpx * tmpx + tmpy * tmpy);
	r_cxy = sqrt(c.x * c.x + c.y * c.y);
	h = 1.0f - c.z * tmpz/(r_cxy * r_zxy + Offset);

	tmpx2 = (c.x * tmpx - c.y * tmpy) * h;
	tmpy2 = (c.y * tmpx + c.x * tmpy) * h;
	tmpz2 = r_cxy * tmpz + r_zxy * c.z;

	// Bring everything together
	z.x = fac_eff * z.x + tmpx2;
	z.y = fac_eff * z.y + tmpy2;
	z.z = fac_eff * z.z + tmpz2;


	// Below the hack that provides a divergent value of (x,y,z) to Mandelbulber
	// although the plain Newton method does always converge

	sq_r = fractal->transformCommon.scale1 / (dot(z - Solution, z - Solution) + Offset);
	z.x = (z.x - Solution.x) * sq_r;
	z.y = -(z.y - Solution.y) * sq_r;
	z.z = -(z.z - Solution.z) * sq_r;

	//REAL dd = length(z) / aux->r;
	//dd = dd + (aux->r * 2.0f - dd) * fractal->transformCommon.scaleA1;
	//aux->DE *= dd;

	if (fractal->analyticDE.enabledFalse)
	{
		aux->DE = aux->DE * fractal->analyticDE.scale1 + fractal->analyticDE.offset0;
	}

	if (fractal->transformCommon.functionEnabledOFalse)
	{
		aux->DE0 = length(z);

		aux->DE0 = 0.5f * log(aux->DE0) * aux->DE0 / (aux->DE);
		if (!fractal->transformCommon.functionEnabledYFalse)
			aux->dist = aux->DE0;
		else
			aux->dist = min(aux->dist, aux->DE0);
	}*/

	//if (fractal->transformCommon.functionEnabledXFalse)
	//	z = zc;

	return z;
}
