/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * rotation 4D

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the function "TransfRotation4dIteration" in the file fractal_formulas.cpp
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 TransfRotation4dIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	Q_UNUSED(aux);

	REAL4 tp;
	if (fractal->transformCommon.rotation44a.x != 0)
	{
		tp = z;
		REAL alpha = fractal->transformCommon.rotation44a.x * M_PI_180;
		z.x = mad(tp.x, native_cos(alpha), tp.y * native_sin(alpha));
		z.y = mad(tp.x, -native_sin(alpha), tp.y * native_cos(alpha));
	}
	if (fractal->transformCommon.rotation44a.y != 0)
	{
		tp = z;
		REAL beta = fractal->transformCommon.rotation44a.y * M_PI_180;
		z.y = mad(tp.y, native_cos(beta), tp.z * native_sin(beta));
		z.z = mad(tp.y, -native_sin(beta), tp.z * native_cos(beta));
	}
	if (fractal->transformCommon.rotation44a.z != 0)
	{
		tp = z;
		REAL gamma = fractal->transformCommon.rotation44a.z * M_PI_180;
		z.x = mad(tp.x, native_cos(gamma), tp.z * native_sin(gamma));
		z.z = mad(tp.x, -native_sin(gamma), tp.z * native_cos(gamma));
	}
	if (fractal->transformCommon.rotation44b.x != 0)
	{
		tp = z;
		REAL delta = fractal->transformCommon.rotation44b.x * M_PI_180;
		z.x = mad(tp.x, native_cos(delta), tp.w * native_sin(delta));
		z.w = mad(tp.x, -native_sin(delta), tp.w * native_cos(delta));
	}
	if (fractal->transformCommon.rotation44b.y != 0)
	{
		tp = z;
		REAL epsilon = fractal->transformCommon.rotation44b.y * M_PI_180;
		z.y = mad(tp.y, native_cos(epsilon), tp.w * native_sin(epsilon));
		z.w = mad(tp.y, -native_sin(epsilon), tp.w * native_cos(epsilon));
	}
	if (fractal->transformCommon.rotation44b.z != 0)
	{
		tp = z;
		REAL zeta = fractal->transformCommon.rotation44b.z * M_PI_180;
		z.z = mad(tp.z, native_cos(zeta), tp.w * native_sin(zeta));
		z.w = mad(tp.z, -native_sin(zeta), tp.w * native_cos(zeta));
	}
	return z;
}