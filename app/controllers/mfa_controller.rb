class MfaController < ApplicationController
  def index
    unless user = User.find_by(id: session[:before_mfa_user_id])
      return redirect_to login_url
    end

    # if user.otp_secret_key.present?
    #   user.otp_secret_key
    #   return render "new"
    # end

    # 認証デバイス登録
    unless user.otp_secret_key.present?
      secret = ROTP::Base32.random
      user.update(otp_secret_key: secret)
    end

    totp = ROTP::TOTP.new(user.otp_secret_key, issuer: "two-factor_sample")
    uri = totp.provisioning_uri("hailong@test.jp")
    @qr = RQRCode::QRCode.new(uri, level: :h)
  end

  def new
  end

  def create
    if user = User.find_by(id: session[:before_mfa_user_id])
      totp = ROTP::TOTP.new(user.otp_secret_key, issuer: "two-factor_sample")
      if totp.verify(params[:otp_code])
        log_in user
        return redirect_to root_url, notice: "認証成功しました!"
      else
        flash.now[:alert] = "認証コードは無効です。"
        return render "new"
      end
    else
      return redirect_to root_url, notice: "ログイン失敗しました!"
    end
  end
end
