cask "opentomac" do
  version "0.4.0"
  sha256 "5b64e2c2100cace062021778695cde6d6a3270cb28e8d7a7c95139ebe4b18c65"

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
