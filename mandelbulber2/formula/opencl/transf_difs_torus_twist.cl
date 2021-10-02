/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2021 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * TransfDifsTorusV3Iteration  fragmentarium code, mdifs by knighty (jan 2012)
 * and http://www.iquilezles.org/www/articles/distfunctions/distfunctions.htm

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_transf_difs_torus_twist.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 TransfDIFSTorusTwistIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	if (fractal->transformCommon.functionEnabledxFalse) z.x = -fabs(z.x);
	if (fractal->transformCommon.functionEnabledyFalse) z.y = -fabs(z.y);
	if (fractal->transformCommon.functionEnabledzFalse) z.z = -fabs(z.z);

	REAL4 zc = z;
	REAL temp;
	// swap axis
	if (fractal->transformCommon.functionEnabledSwFalse)
	{
		temp = zc.x;
		zc.x = zc.z;
		zc.z = temp;
	}

	REAL ang = atan2(zc.y, -zc.x) / M_PI_2x_F;

	if (fractal->transformCommon.functionEnabledAFalse)
	{
		REAL Voff = fractal->transformCommon.scaleA2;
		temp = zc.z - 2.0f * Voff * ang + Voff;
		zc.z = temp - 2.0f * Voff * floor(temp / (2.0f * Voff)) - Voff;
	}

	zc.y = native_sqrt(zc.x * zc.x + zc.y * zc.y) - fractal->transformCommon.radius1;

	ang *= fractal->transformCommon.int6 * M_PI_2_F;
	REAL cosA = native_cos(ang);
	REAL sinB = native_sin(ang);
	temp = zc.z;
	zc.z = zc.y * cosA + zc.z * sinB;
	zc.y = temp * cosA + zc.y * -sinB;

	REAL lenY = fractal->transformCommon.offsetA0;
	REAL lenZ = fractal->transformCommon.offsetB0;
	REAL4 absZ = fabs(zc);

	if (fractal->transformCommon.functionEnabledPFalse)
		lenY += absZ.x * fractal->transformCommon.scaleC0;
	if (fractal->transformCommon.functionEnabledNFalse)
		lenY += absZ.z * fractal->transformCommon.scaleA0;
	if (fractal->transformCommon.functionEnabledMFalse)
		lenZ += absZ.z * fractal->transformCommon.scale0;
	if (fractal->transformCommon.functionEnabledOFalse)
		lenZ += absZ.y * fractal->transformCommon.scaleB0;

	REAL4 d = fabs(zc);
	d.x = d.x * fractal->transformCommon.scaleA0;
	d.y -= fractal->transformCommon.offset01;
	d.z -= fractal->transformCommon.offsetp1;

	d.y = max(d.y - lenY, 0.0f);
	d.z = max(d.z - lenZ, 0.0f);
	aux->DE0 = length(d) - fractal->transformCommon.offset0005;

	if (!fractal->analyticDE.enabledFalse)
		aux->dist = aux->DE0 / (aux->DE + fractal->analyticDE.offset0);
	else
		aux->dist = min(aux->dist, aux->DE0 / (aux->DE + fractal->analyticDE.offset0));

	if (fractal->transformCommon.functionEnabledXFalse) z = zc;
	return z;
}
