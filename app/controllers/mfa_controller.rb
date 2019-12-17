class MfaController < ApplicationController
  def index
    if user_id = session[:before_mfa_user_id]
      @user = User.find_by(id: user_id)
      # デバイス設定
      secret = ROTP::Base32.random
      p secret

      totp = ROTP::TOTP.new(secret, issuer: "two-factor_sample")
      uri = totp.provisioning_uri("hailong@test.jp")

      @qr = RQRCode::QRCode.new(uri, level: :h)
    else
      redirect_to login_url
    end
  end

  def new
  end

  def create
    if user_id = session[:before_mfa_user_id]
      user = User.find_by(id: user_id)

      # テスト確認用
      secret = "63TMGOXBMARHFDZOMNEWPAOYEAJ4UEZ4"
      totp = ROTP::TOTP.new(secret, issuer: "two-factor_sample")
      if totp.verify(params[:otp_code])
        log_in user
        return redirect_to root_url, notice: "Loged in!"
      else
        flash.now[:alert] = "認証コードは無効です。"
        return render "new"
      end
    else
      return redirect_to root_url, notice: "ログイン失敗!"
    end
  end
end
