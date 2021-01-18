Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 by sourceware.org (Postfix) with ESMTPS id 5AD8F385800A
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 14:52:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 5AD8F385800A
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MoNu2-1lpxnd0iCW-00omln for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021
 15:52:01 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id C857DA80988; Mon, 18 Jan 2021 15:52:00 +0100 (CET)
Date: Mon, 18 Jan 2021 15:52:00 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 05/11] Cygwin: Move post-dir unlink check
Message-ID: <20210118145200.GI59030@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210115134534.13290-1-ben@wijen.net>
 <20210115134534.13290-6-ben@wijen.net>
 <20210118110848.GV59030@calimero.vinschen.de>
 <16b76b93-400e-34b3-0822-6fe67decfd4b@wijen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <16b76b93-400e-34b3-0822-6fe67decfd4b@wijen.net>
X-Provags-ID: V03:K1:m8qRdupqdqtEUaKIY/2Jz305fk6ZQPUi+BKWdjx81ldepAMOjOQ
 6KrUmIBpKofI9Ts+t2SJe1jOzTmWSuaGFfKsJPbp3p1Ru80nvb78DpLjkYROun7Dg6zksw6
 YUvYm5HhhCnE57ySEoF1bqbVey/Ub5t4ek64ZYGdodp+HWTfWbxCiyrGcDZ5MRimVwxcCeM
 5wSueZJboGW05FA7wu9SQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3HIHSkGszrQ=:kxseCavgO/xk2Pi+5Yr98B
 eqjp2/rxGzm7E32u+PwU7fpr6FYziPTSz9b7piIWlKcNu936vN6lhueKrBEMkRncL2mRcftPD
 /hL6xzd2s03kYOQbIo9jKTgt7ymmEYrijrU/UdApvfQPLxkaPmaUL46jVV1xvBAfEPzqCuo3b
 m92zna8YuDB8rIDQu7IsHppsWEXbqXeyUZK5xF7vsaYtyNg+nFPfSBvmkp1p41nuJ3U5ef0xr
 gG/S/azDeBDrpxyTT1MluZ7Oz7ePHcqTzKAsjpFefSwz7ENZ0L8iO27bi/sJnEcn5s9Wy+VoP
 t0e4MBJDWlI3C1aryExybSahIdpHXcyTIMXeTaq8ve6+Qtb2Uw+P7KMRYP1t9izi2Bk0oPUel
 UahuRxn0jwh5A9dPY4C/MDqLptb2mils24QlsPun6LgopukSF48tE0G0HdeDx+Qq/t6RpVnEi
 TNAP4/LDtA==
X-Spam-Status: No, score=-101.0 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
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
X-List-Received-Date: Mon, 18 Jan 2021 14:52:03 -0000

On Jan 18 15:31, Ben wrote:
> On 18-01-2021 12:08, Corinna Vinschen via Cygwin-patches wrote:
> > On Jan 15 14:45, Ben Wijen wrote:
> >> Move post-dir unlink check from
> >> fhandler_disk_file::rmdir to _unlink_nt
> > 
> > Why?  It's not much of a problem, codewise, but the commit message
> > could be improved here.
> > 
> Something like this?
>     Cygwin: Move post-dir unlink check
>     
>     Move post-dir unlink check from
>     fhandler_disk_file::rmdir to _unlink_nt
>     
>     This helps in two ways:
>     * Now all checks are in one place
>     * Even if a directory is removed through
>       _unlink_nt, but not rmdir, the return
>       value can be trusted.

Sure, looks good.  You don't have to cramp the text into the first 40
cols, 80 is fine.


Thanks,
Corinna
