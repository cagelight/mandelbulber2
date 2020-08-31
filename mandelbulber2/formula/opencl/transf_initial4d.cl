/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2020 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * quadray and z.w = length (z) initial conditions for 4D, from Aexion
 * reference http://www.fractalforums.com/the-3d-mandelbulb/quadray-sets/

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_transf_scale4d.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 TransfInitial4d(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	if (aux->i >= fractal->transformCommon.startIterationsD
			&& aux->i < fractal->transformCommon.stopIterationsD1)
	{
		if (!fractal->transformCommon.functionEnabledFalse)
		{
			z = (REAL4)(z.x + z.y + z.z, -z.x - z.y + z.z, -z.x + z.y - z.z, z.x - z.y - z.z);
			z = fabs(z);
			z = fabs(z - fractal->transformCommon.offsetA0000);
		}
		else
		{
			z = (REAL4)(z.x, z.y, z.z, length(z));
		}
		aux->const_c = z * fractal->transformCommon.scale1111;
	}
	// DE tweak
	if (!fractal->analyticDE.enabledFalse) aux->DE = aux->DE * length(z) / aux->r;

	aux->DE = aux->DE * fractal->analyticDE.scale1 + fractal->analyticDE.offset0;

	return z;
}
