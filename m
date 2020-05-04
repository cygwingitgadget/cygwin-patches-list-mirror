Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by sourceware.org (Postfix) with ESMTPS id 45330385AC19
 for <cygwin-patches@cygwin.com>; Mon,  4 May 2020 09:27:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 45330385AC19
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MBUuV-1jIdCa3Z79-00D1EA for <cygwin-patches@cygwin.com>; Mon, 04 May 2020
 11:27:03 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 59532A80FA3; Mon,  4 May 2020 11:27:02 +0200 (CEST)
Date: Mon, 4 May 2020 11:27:02 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] setup_pseudoconsole(): handle missing/incorrect helper
 gracefully
Message-ID: <20200504092702.GA3947@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <nycvar.QRO.7.76.6.2005021459560.18039@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2005021459560.18039@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:0nCTjJuE20/fazNiXxPUW7lvIkH8oMQXQvnQATUNNT2mqbS48Ik
 EB1tassIUx4SajJz4CCVoUmxA/hp0/y7Cig++oCrdafgSaYwmSmJKoBqUxWFiVkioYC4tFd
 tWrtLtzxcNNS3acxC6S4dTILpVGApDU7jjTl26vvvEOxFJY1yqxnrd88Vz+J765RUvNAZpw
 9xvGjbSEdZCSaIPoNWC5w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:M2eRYY9vryA=:VKF20VF7Zql894uiO/ueZd
 q8x13aV/qQ6QOConO6uakZFWCVlRcksCSawyfYhUWiRkeKHJ+CYTKZun8dtUI4F8HlGDYLDBp
 rSqa4TDlRDWS08UKETBqahU2VqWsU8GXW6Dz/ZiFZKzfzkrqFjamjiEX3y9eMWsPJm6zeqN+1
 JIQhqRhoUaGOysF+Llia9jfyWuqd7/h9RBYwqWmft3caA3iUPrVdybSug5HF76cU125DmpLSu
 keQvKNAKpFE87ZF1fYSwrX41sM24qfW1+9jBoPW54WkbIUCHkm7IVVQui51Oa0jpdFwHUV+KS
 SasZU91ojYjh+U4QXtoxCOOWp4Mhhwky/6T1YPGf2buVFy88hckz1bVTL+zewPTBO2IueG66a
 l0OreqyCPUoSHWIs7VLcZvuW5//bQFiy/0DfIbkBnHe6fSI7joN3XvbI5DfR9ObsSuwU8gzFN
 NADDFVRDVvl2u1xYcfK/CqNemECAlsuhoOY2fEjx5U+Jr5SnDFpDt0Y29jKe2zrdSVTAVY4mc
 r1aPLd3lXY61K94RkhSioH8CzfodipNOWVWQYtPxHY1tbX2LLFKNzE0LX+JBQSKcc+ZfTYZ4L
 k2cFVMNMgtT3RGHJONRLpJ6Klb8Fd11qOhpK2AJRvpglF+nCcFIrUOtdWz6qjhjiatzNobVSW
 6+9IMLMd/vEWTfjh9fHUPqsYPDYpWWdOlFsbsXKV5VMe1MCMocex1BVjgz9A1LfBeNpjB6dRq
 1Kca/SIDn5M707Ca9FEy8nP8g2fiG1GonOKzXA1tWQYvE1qfl12q8ZXCjKwenTj/5OHHpwQrj
 a5lAeZn6RZ3vzKfOwQ88+ZyqA65QENDYgI4MvasAfJalEkODJP/+ByILwYM0hbbj/nBXNcZ
X-Spam-Status: No, score=-97.9 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Mon, 04 May 2020 09:27:07 -0000

On May  2 15:03, Johannes Schindelin wrote:
> When `cygwin-console-helper.exe` is either missing, or corresponds to a
> different Cygwin runtime, we currently wait forever while setting up
> access to the pseudo console, even long after the process is gone that
> was supposed to signal that it set up access to the pseudo console.
> 
> Let's handle that more gracefully: if the process exited without
> signaling, we cannot use the pseudo console. In that case, let's just
> fall back to not using it.

Pushed.


Thanks,
Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
