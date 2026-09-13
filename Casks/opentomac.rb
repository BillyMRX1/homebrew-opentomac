cask "opentomac" do
  version "0.5.0"
  sha256 "92072f86d4d0147236836ef8014e5de58c98feed17a1ee47726ef629ba96e699"

  url "https://github.com/BillyMRX1/opentomac/releases/download/v#{version}/opentomac-v#{version}-macos.dmg"
  name "opentomac"
  desc "Local-first continuity app for pairing with an Android phone"
  homepage "https://github.com/BillyMRX1/opentomac"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Opentomac.app"

  zap trash: [
    "~/Library/Application Support/opentomac",
    "~/Library/Preferences/dev.opentomac.mac.plist",
    "~/Library/Saved Application State/dev.opentomac.mac.savedState",
  ]

  caveats do
    <<~EOS
      opentomac releases are not signed or notarized, so macOS Gatekeeper
      blocks the first launch. Approve the app once via System Settings >
      Privacy & Security > Open Anyway, or clear the quarantine flag:
        xattr -d com.apple.quarantine /Applications/Opentomac.app
      (Homebrew 6 removed the --no-quarantine install flag.)
    EOS
  end
end
