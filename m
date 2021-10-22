Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by sourceware.org (Postfix) with ESMTPS id 1DDFE3858416
 for <cygwin-patches@cygwin.com>; Fri, 22 Oct 2021 15:11:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 1DDFE3858416
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M1HuU-1mfbA01UVO-002lxe for <cygwin-patches@cygwin.com>; Fri, 22 Oct 2021
 17:11:14 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id B10DBA81066; Fri, 22 Oct 2021 17:11:13 +0200 (CEST)
Date: Fri, 22 Oct 2021 17:11:13 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Make native clipboard layout same for 32- and
 64-bit
Message-ID: <YXLUkU6Nc3qAXLyp@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20211007052237.7139-1-mark@maxrnd.com>
 <20211008185210.cac713f28dea727a1467cf94@nifty.ne.jp>
 <29514de9-0d19-0d22-b8e1-3bfbce11589b@cornell.edu>
 <7dd31f61-43a1-4e4d-2e1a-dc79606263d5@dronecode.org.uk>
 <037a8027-8969-df1e-ccb5-6a736578cec5@cornell.edu>
 <6de24f8c-bd21-cd4f-18ff-ece3fef85b89@maxrnd.com>
 <ee8b46bd-f8f4-85da-be25-233c3cb60c71@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ee8b46bd-f8f4-85da-be25-233c3cb60c71@cornell.edu>
X-Provags-ID: V03:K1:PJFHNq6JttFmXh1N3FNfyL7yQhI/A+qf89lHR0eLS+DxncSUpfy
 tV+ufWj1sh1yExbt3KErd/A/WdO6zMIlCwwuRkCUWI4Y1focI+ZEN+JTlBFx9eP6VuaYuIS
 V/Sr/N8KvJ6y08nP53/XvxfqqUCf45wTjivbzUUdqrdV5iF+BNV06WZPfRMT2npyRduL40A
 UBGYbUWCM7/0bak9/4r1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KF08Pdr7wxA=:8fQQkkosSf+v9JXX+bSuo7
 KxZmQJY9nnH7oofnyrTZw3yNV6vo07L9yZPATh5lZEDv3p7Ozb+LhQAa8X0Eykth72dSq7lhD
 1sW0i3piL30WIhheMaPQXq8K0rIAc9CVdnscQ2Oy6L3sgcaLDcMRd6/mOtG1Ol5iCTVnWudSQ
 dUEnYct4HzbbMHojbLyId5GeAKIxwVgyVNZ1prpLOvmW0yDx26/kZcAqJeKV81vVizxNTbLqJ
 ZDl9EX42ltZNE+i6LpWKPr13DGfTuf2T0NnfF8e4PICtnuHDfLQALN5SuHQzGASzBOx3PfebW
 ueRpLM13Ntw283CU9+rtm/T8DfH45tkXftSENCxth3tFsddy6QGNZvcQkLeXYqXxGA5XnTEMj
 sOQ7iFGe2RfhannxCxRjaA6k/8r7iHMK+vMHV2AVmUE4etOGVWYST8nxLx1DfoZYfYnLkh4H8
 utH95ylaZRQZu1EslfLTtmmzkuznb8enWA0R154emWCW0T4DqfXDneuO5LJgK4uf6ttm3J9H8
 jtX+Xxk/6itS90oAM7zIlh2iAYCFMxiqRtiRG7Tz1DOu59umcMWc7mFlE4w5kLI7kCvR5xEmn
 vmNUgRfvjOXt0eG1ru9PNI0mh6W0/WIOEP7b3MsOQQyfbb7Yi9tGMaBYeRRI49DQgWQDJjlR2
 EOZtNETHRxbSg/yB11ozFId5TVoVUWHVWuq0P2JMQr1752gL18m6ept+88sLcxA9MxZeVE3Ie
 i2zpkrMfx4SoEhX6
X-Spam-Status: No, score=-99.7 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Fri, 22 Oct 2021 15:11:17 -0000

On Oct 11 08:11, Ken Brown wrote:
> On 10/11/2021 2:13 AM, Mark Geisert wrote:
> > It's just that after submitting the patch I realized that, if we really
> > are going to support both Cygwin archs (x86_64 and i686), there is still
> > the issue of different cygcb_t layouts between Cygwin versions being
> > ignored.
> > 
> > Specifically, the fhandler_clipboard::fstat routine can't tell which
> > Cygwin environment has set the clipboard contents.  My original patch
> > takes care of 32-bit and 64-bit, providing both are running Cygwin >=
> > 3.3.0 (presumably).  What if it was a different version (pre 3.3.0) that
> > set the contents?
> 
> I wonder if this is worth the trouble.  Right now we have a problem in which
> data written to /dev/clipboard in one arch can't be read in the other arch.
> The fix will appear in Cygwin 3.3.0.  Do we really have to try to make the
> fix apply retroactively in case the user updates one arch but not the other?

Just to close this up prior to the 3.3.0 release...

Given we never actually strived for 32<->64 bit interoperability, it's
hard to argue why this should be different for the clipboard stuff.

Running 32 and 64 bit Cygwin versions in parallel doesn't actually make
much sense for most people anyway, unless they explicitely develop for
32 and 64 bit systems under Cygwin.  From a productivity point of view
there's no good reason to run more than one arch.

So I agree with Ken here.  It's probably not worth the trouble.


Corinna
