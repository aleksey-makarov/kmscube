{ lib, stdenv, fetchgit, libpng, libdrm, libGL, mesa, pkg-config, meson, ninja, gst_all_1, makeWrapper }:

stdenv.mkDerivation {
  pname = "kmscube-latest";

  version = "git";
  src = ./.;

  nativeBuildInputs = [ meson ninja pkg-config makeWrapper ];
  buildInputs = [ libpng libdrm libGL mesa gst_all_1.gstreamer gst_all_1.gst-plugins-base gst_all_1.gst-plugins-good gst_all_1.gst-plugins-bad gst_all_1.gst-plugins-ugly ];

  postInstall = ''
    wrapProgram $out/bin/kmscube --prefix GST_PLUGIN_SYSTEM_PATH_1_0 : "$GST_PLUGIN_SYSTEM_PATH_1_0"
  '';

  meta = with lib; {
    description = "Example OpenGL app using KMS/GBM";
    homepage = "https://gitlab.freedesktop.org/mesa/kmscube";
    license = licenses.mit;
    maintainers = with maintainers; [ dezgeg ];
    platforms = platforms.linux;
  };
}
