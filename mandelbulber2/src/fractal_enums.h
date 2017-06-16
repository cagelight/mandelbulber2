/**
 * Mandelbulber v2, a 3D fractal generator       ,=#MKNmMMKmmßMNWy,
 *                                             ,B" ]L,,p%%%,,,§;, "K
 * Copyright (C) 2016 Mandelbulber Team        §R-==%w["'~5]m%=L.=~5N
 *                                        ,=mm=§M ]=4 yJKA"/-Nsaj  "Bw,==,,
 * This file is part of Mandelbulber.    §R.r= jw",M  Km .mM  FW ",§=ß., ,TN
 *                                     ,4R =%["w[N=7]J '"5=],""]]M,w,-; T=]M
 * Mandelbulber is free software:     §R.ß~-Q/M=,=5"v"]=Qf,'§"M= =,M.§ Rz]M"Kw
 * you can redistribute it and/or     §w "xDY.J ' -"m=====WeC=\ ""%""y=%"]"" §
 * modify it under the terms of the    "§M=M =D=4"N #"%==A%p M§ M6  R' #"=~.4M
 * GNU General Public License as        §W =, ][T"]C  §  § '§ e===~ U  !§[Z ]N
 * published by the                    4M",,Jm=,"=e~  §  §  j]]""N  BmM"py=ßM
 * Free Software Foundation,          ]§ T,M=& 'YmMMpM9MMM%=w=,,=MT]M m§;'§,
 * either version 3 of the License,    TWw [.j"5=~N[=§%=%W,T ]R,"=="Y[LFT ]N
 * or (at your option)                   TW=,-#"%=;[  =Q:["V""  ],,M.m == ]N
 * any later version.                      J§"mr"] ,=,," =="""J]= M"M"]==ß"
 *                                          §= "=C=4 §"eM "=B:m|4"]#F,§~
 * Mandelbulber is distributed in            "9w=,,]w em%wJ '"~" ,=,,ß"
 * the hope that it will be useful,                 . "K=  ,=RMMMßM"""
 * but WITHOUT ANY WARRANTY;                            .'''
 * without even the implied warranty
 * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *
 * See the GNU General Public License for more details.
 * You should have received a copy of the GNU General Public License
 * along with Mandelbulber. If not, see <http://www.gnu.org/licenses/>.
 *
 * ###########################################################################
 *
 * Authors: Krzysztof Marczak (buddhi1980@gmail.com)
 *
 * distance estimation types
 */

#ifndef MANDELBULBER2_SRC_FRACTAL_ENUMS_H_
#define MANDELBULBER2_SRC_FRACTAL_ENUMS_H_

#define NUMBER_OF_FRACTALS 9

namespace fractal
{
enum enumDEMethod
{
	preferredDEMethod = 0,
	forceDeltaDEMethod = 1,
};

enum enumDEFunctionType
{
	preferredDEFunction = 0,
	linearDEFunction = 1,
	logarithmicDEFunction = 2,
	pseudoKleinianDEFunction = 3,
	numberOfDEFunctions = 3, // used to prepare array
	withoutDEFunction = 99
};

enum enumCPixelAddition
{
	cpixelEnabledByDefault = 0,
	cpixelDisabledByDefault = 1,
	cpixelAlreadyHas = 2
};

enum enumDEType
{
	analyticDEType,
	deltaDEType
};

enum enumDEAnalyticFunction
{
	analyticFunctionNone = 0,
	analyticFunctionLinear = 1,
	analyticFunctionLogarithmic = 2,
	analyticFunctionIFS = 3,
	analyticFunctionPseudoKleinian = 4,
};

enum enumColoringFunction
{
	coloringFunctionDefault = 0,
	coloringFunctionABox = 1,
	coloringFunctionIFS = 2,
	coloringFunctionAmazingSurf = 3,
	coloringFunctionABox2 = 4,
	coloringFunctionDonut = 5,
};
};

#endif /* MANDELBULBER2_SRC_FRACTAL_ENUMS_H_ */
