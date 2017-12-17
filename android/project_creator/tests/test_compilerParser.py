from unittest import TestCase
from compiler_parser import CompilerParser

object = '''/bin/bash -c "(PWD=/proc/self/cwd prebuilts/misc/linux-x86/ccache/ccache prebuilts/clang/host/linux-x86/clang-2690385/bin/clang++ -I out/host/linux-x86/gen/STATIC_LIBRARIES/libaapt2_intermediates -I external/protobuf/src -I out/host/linux-x86/gen/STATIC_LIBRARIES/libaapt2_intermediates/proto -I frameworks/base/tools/aapt2 -I out/host/linux-x86/obj/STATIC_LIBRARIES/libaapt2_intermediates -I out/host/linux-x86/gen/STATIC_LIBRARIES/libaapt2_intermediates -I libnativehelper/include/nativehelper \$(cat out/host/linux-x86/obj/STATIC_LIBRARIES/libaapt2_intermediates/import_includes) -isystem system/core/include -isystem system/media/audio/include -isystem hardware/libhardware/include -isystem hardware/libhardware_legacy/include -isystem hardware/ril/include -isystem libnativehelper/include -isystem frameworks/native/include -isystem frameworks/native/opengl/include -isystem frameworks/av/include -isystem frameworks/base/include -isystem tools/include -isystem out/host/linux-x86/obj/include -c    -fno-exceptions -Wno-multichar -m64 -Wa,--noexecstack -fPIC -no-canonical-prefixes -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 -fstack-protector -D__STDC_FORMAT_MACROS -D__STDC_CONSTANT_MACROS -DANDROID -fmessage-length=0 -W -Wall -Wno-unused -Winit-self -Wpointer-arith -O2 -g -fno-strict-aliasing -DNDEBUG -UDEBUG  -D__compiler_offsetof=__builtin_offsetof -Werror=int-conversion -Wno-reserved-id-macro -Wno-format-pedantic -Wno-unused-command-line-argument -fcolor-diagnostics   --gcc-toolchain=prebuilts/gcc/linux-x86/host/x86_64-linux-glibc2.15-4.8 -fstack-protector-strong    --gcc-toolchain=prebuilts/gcc/linux-x86/host/x86_64-linux-glibc2.15-4.8 --sysroot prebuilts/gcc/linux-x86/host/x86_64-linux-glibc2.15-4.8/sysroot -target x86_64-linux-gnu   -Wsign-promo  -Wno-inconsistent-missing-override   --gcc-toolchain=prebuilts/gcc/linux-x86/host/x86_64-linux-glibc2.15-4.8 --sysroot prebuilts/gcc/linux-x86/host/x86_64-linux-glibc2.15-4.8/sysroot -isystem prebuilts/gcc/linux-x86/host/x86_64-linux-glibc2.15-4.8/x86_64-linux/include/c++/4.8 -isystem prebuilts/gcc/linux-x86/host/x86_64-linux-glibc2.15-4.8/x86_64-linux/include/c++/4.8/x86_64-linux -isystem prebuilts/gcc/linux-x86/host/x86_64-linux-glibc2.15-4.8/x86_64-linux/include/c++/4.8/backward -target x86_64-linux-gnu  -Wall -Werror -Wno-unused-parameter -UNDEBUG -fPIC -D_USING_LIBCXX -DGOOGLE_PROTOBUF_NO_RTTI -std=gnu++14 -std=c++11 -Wno-missing-field-initializers -fno-exceptions -fno-rtti -nostdinc++  -Werror=int-to-pointer-cast -Werror=pointer-to-int-cast  -Werror=address-of-temporary -Werror=null-dereference -Werror=return-type    -MD -MF out/host/linux-x86/obj/STATIC_LIBRARIES/libaapt2_intermediates/proto/TableProtoDeserializer.d -o out/host/linux-x86/obj/STATIC_LIBRARIES/libaapt2_intermediates/proto/TableProtoDeserializer.o frameworks/base/tools/aapt2/proto/TableProtoDeserializer.cpp ) && (cp out/host/linux-x86/obj/STATIC_LIBRARIES/libaapt2_intermediates/proto/TableProtoDeserializer.d out/host/linux-x86/obj/STATIC_LIBRARIES/libaapt2_intermediates/proto/TableProtoDeserializer.P; sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\\\\$//' -e '/^\$/ d' -e 's/\$/ :/' < out/host/linux-x86/obj/STATIC_LIBRARIES/libaapt2_intermediates/proto/TableProtoDeserializer.d >> out/host/linux-x86/obj/STATIC_LIBRARIES/libaapt2_intermediates/proto/TableProtoDeserializer.P; rm -f out/host/linux-x86/obj/STATIC_LIBRARIES/libaapt2_intermediates/proto/TableProtoDeserializer.d )"'''
library = '''bin/bash -c "prebuilts/misc/linux-x86/ccache/ccache prebuilts/clang/host/linux-x86/clang-2690385/bin/clang++ -nostdlib -Wl,-soname,camera.imx6.so -Wl,--gc-sections -shared  -Lout/target/product/maxwell10/obj/lib out/target/product/maxwell10/obj/lib/crtbegin_so.o      out/target/product/maxwell10/obj/SHARED_LIBRARIES/camera.imx6_intermediates/CameraHAL.o out/target/product/maxwell10/obj/SHARED_LIBRARIES/camera.imx6_intermediates/Camera.o out/target/product/maxwell10/obj/SHARED_LIBRARIES/camera.imx6_intermediates/Metadata.o out/target/product/maxwell10/obj/SHARED_LIBRARIES/camera.imx6_intermediates/Stream.o out/target/product/maxwell10/obj/SHARED_LIBRARIES/camera.imx6_intermediates/VendorTags.o out/target/product/maxwell10/obj/SHARED_LIBRARIES/camera.imx6_intermediates/CameraUtils.o out/target/product/maxwell10/obj/SHARED_LIBRARIES/camera.imx6_intermediates/MessageQueue.o out/target/product/maxwell10/obj/SHARED_LIBRARIES/camera.imx6_intermediates/VideoStream.o out/target/product/maxwell10/obj/SHARED_LIBRARIES/camera.imx6_intermediates/JpegBuilder.o out/target/product/maxwell10/obj/SHARED_LIBRARIES/camera.imx6_intermediates/Ov5640Csi.o out/target/product/maxwell10/obj/SHARED_LIBRARIES/camera.imx6_intermediates/Ov5640Mipi.o out/target/product/maxwell10/obj/SHARED_LIBRARIES/camera.imx6_intermediates/Ov5642Csi.o out/target/product/maxwell10/obj/SHARED_LIBRARIES/camera.imx6_intermediates/Max9286Mipi.o out/target/product/maxwell10/obj/SHARED_LIBRARIES/camera.imx6_intermediates/YuvToJpegEncoder.o out/target/product/maxwell10/obj/SHARED_LIBRARIES/camera.imx6_intermediates/USPStream.o out/target/product/maxwell10/obj/SHARED_LIBRARIES/camera.imx6_intermediates/DMAStream.o out/target/product/maxwell10/obj/SHARED_LIBRARIES/camera.imx6_intermediates/UvcDevice.o out/target/product/maxwell10/obj/SHARED_LIBRARIES/camera.imx6_intermediates/Tc358743.o out/target/product/maxwell10/obj/SHARED_LIBRARIES/camera.imx6_intermediates/TVINDevice.o out/target/product/maxwell10/obj/SHARED_LIBRARIES/camera.imx6_intermediates/TVIN8DvDevice.o out/target/product/maxwell10/obj/SHARED_LIBRARIES/camera.imx6_intermediates/VADCTVINDevice.o out/target/product/maxwell10/obj/SHARED_LIBRARIES/camera.imx6_intermediates/MMAPStream.o out/target/product/maxwell10/obj/SHARED_LIBRARIES/camera.imx6_intermediates/UvcMJPGDevice.o out/target/product/maxwell10/obj/SHARED_LIBRARIES/camera.imx6_intermediates/MJPGStream.o       out/target/product/maxwell10/obj/SHARED_LIBRARIES/camera.imx6_intermediates/NV12_resize.o        -Wl,--whole-archive   -Wl,--no-whole-archive   out/target/product/maxwell10/obj/STATIC_LIBRARIES/libunwind_llvm_intermediates/libunwind_llvm.a out/target/product/maxwell10/obj/STATIC_LIBRARIES/libcompiler_rt-extras_intermediates/libcompiler_rt-extras.a   prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9/bin/../lib/gcc/arm-linux-androideabi/4.9/../../../../arm-linux-androideabi/lib/armv7-a/libatomic.a prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9/bin/../lib/gcc/arm-linux-androideabi/4.9/armv7-a/libgcc.a -lcamera_metadata -lcutils -llog -lsync -lutils -lc -ljpeg -ljhead -lion -lg2d -lbinder -lcamera_client -lhardware_legacy -l_vpu_wrapper -lc++ -ldl -lc -lm  -o out/target/product/maxwell10/obj/SHARED_LIBRARIES/camera.imx6_intermediates/LINKED/camera.imx6.so   -Wl,-z,noexecstack -Wl,-z,relro -Wl,-z,now -Wl,--build-id=md5 -Wl,--warn-shared-textrel -Wl,--fatal-warnings -Wl,--icf=safe -Wl,--hash-style=gnu -Wl,--no-undefined-version -Wl,--fix-cortex-a8    -target arm-linux-androideabi -Bprebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9/arm-linux-androideabi/bin   -Wl,--exclude-libs,libunwind_llvm.a -Wl,--no-undefined out/target/product/maxwell10/obj/lib/crtend_so.o"'''
objectClang = '''[ 75% 25/33] /bin/bash -c "(PWD=/proc/self/cwd prebuilts/misc/linux-x86/ccache/ccache prebuilts/clang/host/linux-x86/clang-2690385/bin/clang -I external/linux-lib/pxp -I system/core/include -I system/media/camera/include -I external/jpeg -I external/jhead -I device/fsl-proprietary/include -I external/fsl_vpu_omx/OpenMAXIL/src/component/vpu_wrapper -I external/fsl_imx_omx/OpenMAXIL/src/component/vpu_wrapper -I hardware/imx/display/gralloc_v2 -I system/core/libion/include -I hardware/imx/libcamera3 -I out/target/product/maxwell10/obj/SHARED_LIBRARIES/camera.imx6_intermediates -I out/target/product/maxwell10/gen/SHARED_LIBRARIES/camera.imx6_intermediates -I libnativehelper/include/nativehelper \$(cat out/target/product/maxwell10/obj/SHARED_LIBRARIES/camera.imx6_intermediates/import_includes) -isystem system/media/audio/include -isystem hardware/libhardware/include -isystem hardware/libhardware_legacy/include -isystem hardware/ril/include -isystem libnativehelper/include -isystem frameworks/native/include -isystem frameworks/native/opengl/include -isystem frameworks/av/include -isystem frameworks/base/include -isystem out/target/product/maxwell10/obj/include -isystem device/fsl/common/kernel-headers -isystem bionic/libc/arch-arm/include -isystem bionic/libc/include -isystem bionic/libc/kernel/uapi -isystem bionic/libc/kernel/common -isystem bionic/libc/kernel/uapi/asm-arm -isystem bionic/libm/include -isystem bionic/libm/include/arm -c    -fno-exceptions -Wno-multichar -msoft-float -ffunction-sections -fdata-sections -funwind-tables -fstack-protector-strong -Wa,--noexecstack -Werror=format-security -D_FORTIFY_SOURCE=2 -fno-short-enums -no-canonical-prefixes -march=armv7-a -mfloat-abi=softfp -mfpu=neon -DANDROID -fmessage-length=0 -W -Wall -Wno-unused -Winit-self -Wpointer-arith -Werror=return-type -Werror=non-virtual-dtor -Werror=address -Werror=sequence-point -Werror=date-time -DNDEBUG -g -Wstrict-aliasing=2 -DNDEBUG -UDEBUG  -D__compiler_offsetof=__builtin_offsetof -Werror=int-conversion -Wno-reserved-id-macro -Wno-format-pedantic -Wno-unused-command-line-argument -fcolor-diagnostics -nostdlibinc  -target arm-linux-androideabi    -target arm-linux-androideabi -Bprebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9/arm-linux-androideabi/bin    -std=gnu99     -mthumb -Os -fomit-frame-pointer -fno-strict-aliasing   -DBOARD_HAVE_VPU -DHAVE_FSL_IMX_IPU -Wall -Wextra -fvisibility=hidden -fPIC -D_USING_LIBCXX   -Werror=int-to-pointer-cast -Werror=pointer-to-int-cast  -Werror=address-of-temporary -Werror=null-dereference -Werror=return-type  -MD -MF out/target/product/maxwell10/obj/SHARED_LIBRARIES/camera.imx6_intermediates/NV12_resize.d -o out/target/product/maxwell10/obj/SHARED_LIBRARIES/camera.imx6_intermediates/NV12_resize.o hardware/imx/libcamera3/NV12_resize.c ) && (cp out/target/product/maxwell10/obj/SHARED_LIBRARIES/camera.imx6_intermediates/NV12_resize.d out/target/product/maxwell10/obj/SHARED_LIBRARIES/camera.imx6_intermediates/NV12_resize.P; sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\\\\$//' -e '/^\$/ d' -e 's/\$/ :/' < out/target/product/maxwell10/obj/SHARED_LIBRARIES/camera.imx6_intermediates/NV12_resize.d >> out/target/product/maxwell10/obj/SHARED_LIBRARIES/camera.imx6_intermediates/NV12_resize.P; rm -f out/target/product/maxwell10/obj/SHARED_LIBRARIES/camera.imx6_intermediates/NV12_resize.d )"'''


class TestCompilerParser(TestCase):
    def test_parse(self):
        return
        # self.fail()

    def test_parseLineObject(self):
        p = CompilerParser(None)
        f = p.parseLine(object)
        systemIncludes = ['system/core/include',
                          'system/media/audio/include',
                          'hardware/libhardware/include',
                          'hardware/libhardware_legacy/include',
                          'hardware/ril/include',
                          'libnativehelper/include',
                          'frameworks/native/include',
                          'frameworks/native/opengl/include',
                          'frameworks/av/include',
                          'frameworks/base/include',
                          'tools/include',
                          'out/host/linux-x86/obj/include',
                          'prebuilts/gcc/linux-x86/host/x86_64-linux-glibc2.15-4.8/x86_64-linux/include/c++/4.8',
                          'prebuilts/gcc/linux-x86/host/x86_64-linux-glibc2.15-4.8/x86_64-linux/include/c++/4.8/x86_64-linux',
                          'prebuilts/gcc/linux-x86/host/x86_64-linux-glibc2.15-4.8/x86_64-linux/include/c++/4.8/backward']

        self.assertEqual(
            "out/host/linux-x86/obj/STATIC_LIBRARIES/libaapt2_intermediates/proto/TableProtoDeserializer.o",
            f.output)
        self.assertEqual("frameworks/base/tools/aapt2/proto/TableProtoDeserializer.cpp", f.source)
        self.assertEqual(systemIncludes, f.systemIncludes)

    def test_parseLineLibrary(self):
        p = CompilerParser(None)
        f = p.parseLine(library)
        self.assertEqual(None, f)

    def test_parseLineClang(self):
        p = CompilerParser(None)
        f = p.parseLine(objectClang)
        systemIncludes = ['system/media/audio/include',
                          'hardware/libhardware/include',
                          'hardware/libhardware_legacy/include',
                          'hardware/ril/include',
                          'libnativehelper/include',
                          'frameworks/native/include',
                          'frameworks/native/opengl/include',
                          'frameworks/av/include',
                          'frameworks/base/include',
                          'out/target/product/maxwell10/obj/include',
                          'device/fsl/common/kernel-headers',
                          'bionic/libc/arch-arm/include',
                          'bionic/libc/include',
                          'bionic/libc/kernel/uapi',
                          'bionic/libc/kernel/common',
                          'bionic/libc/kernel/uapi/asm-arm',
                          'bionic/libm/include',
                          'bionic/libm/include/arm']
        self.assertEqual(
            "out/target/product/maxwell10/obj/SHARED_LIBRARIES/camera.imx6_intermediates/NV12_resize.o",
            f.output)
        self.assertEqual("hardware/imx/libcamera3/NV12_resize.c", f.source)
        self.assertEqual(systemIncludes, f.systemIncludes)
