# Copyright 2017, DigitalGlobe, Inc.
#
# This program is free software; you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation; either version 2 of the License, or (at your option) any later
# version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
# details.

import glob2
import os

import gippy
import gippy.algorithms as alg

from gbdx_task_interface import GbdxTaskInterface


class NdwiTask(GbdxTaskInterface):
    gbdx_connection = None

    def invoke(self):

        # Get inputs
        img = self.get_input_data_port('image')

        result_dir = self.get_output_data_port('result')
        os.makedirs(result_dir)

        # vectorize threshdolded (ie now binary) image
        all_lower = glob2.glob('%s/**/*.tif' % img)

        for img_file in all_lower:
            geoimg = gippy.GeoImage(img_file, True).select(['green', 'nir'])
            fout = os.path.join(result_dir, 'result.tif')
            alg.indices(geoimg, ['ndwi'], filename=fout)

        self.reason = 'Successfully computed NDWI'


if __name__ == "__main__":
    with NdwiTask() as task:
        task.invoke()
