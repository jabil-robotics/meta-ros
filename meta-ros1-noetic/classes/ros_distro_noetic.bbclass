# Every ROS recipe, generated or not, must contain "inherit ros_distro_${ROS_DISTRO}".
#
# Copyright (c) 2020 LG Electronics, Inc.

ROS_DISTRO = "noetic"

inherit ${ROS_DISTRO_TYPE}_distro

# HACK until "python-qt-binding" builds
ROS_EXEC_DEPENDS:remove = "python-qt-binding"

# openembedded-core removed "BSD" as a valid generic license, but most of the
# machine-generated recipes in this layer use it, leading to a wall of
# license-file-missing QA warnings during the image do_rootfs task. So, create
# a mapping to treat BSD as a recognized license. Also make do_populate_lic
# task depend on this so that this change will actually re-run (otherwise the
# wall of warnings would remain cuz the licenses collected in sstate still
# would lack generic_BSD until something else forces each ROS recipe to re-run.
SPDXLICENSEMAP[BSD] = "BSD-3-Clause"
do_populate_lic[vardeps] += "SPDXLICENSEMAP[BSD]"
