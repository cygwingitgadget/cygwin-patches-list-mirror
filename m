Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by sourceware.org (Postfix) with ESMTPS id E51EF386F421
 for <cygwin-patches@cygwin.com>; Thu, 27 Aug 2020 08:49:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org E51EF386F421
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MwPjf-1kRVvP2Xgb-00sJnz for <cygwin-patches@cygwin.com>; Thu, 27 Aug 2020
 10:49:18 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 3BB4DA83A77; Thu, 27 Aug 2020 10:49:18 +0200 (CEST)
Date: Thu, 27 Aug 2020 10:49:18 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/3] CI update
Message-ID: <20200827084918.GV3272@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200826210409.2497-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200826210409.2497-1-jon.turney@dronecode.org.uk>
X-Provags-ID: V03:K1:02FZsz5devEc2TBNNjSSdTJAYP62bhD8E9QXUo5U4Du+yu0Y8sR
 EcryaOkvlDuQNkAm1hEhBLR9SSJyiK8+pdN2o7JbKevnyE9hGO0OMQDXXVq2ii/8qbx2V+S
 yYks9gYznNNqvG3DSb2qzHGwcKeFMvvjdIXlDDzDZ0cMpNqDifx6LaLry7tuE3vLFS9zQTt
 1jmyZnMfQTwQyzCE7V9Hw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QDj4eOzqLoE=:SIaQOWRYWwjc5kcsbgHth/
 KSOjMofcLPsBuF2DqU42I/nxeeAyZlEjCIo69vNjaWZUdlt/aQxaiNKsxkS2jRfwyIkbxAs6V
 EqRVSfSjsSj0dtBrZNc/dZbxHcPZGa/JgpIrsJdb6ZjC91jjvE+tySTjkmJbIorZtS8dqlTTX
 4KgXhPIc3v/GJ2B1aTl0CfPCC4FPaCvcw+hJHSDlXx+JWm5hodBlLIoq2nd9UmpCAzcp4bnQL
 CoJPmPD2ura3/Uli9tdtKE98OFMI4cy9xkcS4vijMtVkqPX6XVadqahDD/7UTUAmzqbg1fK6Y
 VY5PR2Sjn2M5/1s3KsTD8VoGnGBGbi+AAjAXRlsQPKN/5hDrbJGc0ViXOI98Ii1LiKb62hUEo
 PTxlTdy8eKCqex1mlckK/N9W2KLMj1Qw+Gy1fL9EpQDYUZFrzvl639RcfM+Kl8Xe47Dy5RaWW
 ov702GUCoR0kYPAESdgwtYuFF27W07R2jGRTHMONK3o4H6a910tvb1QL+m9QEafgUm4HvoHMV
 MlU8tG6H1sh3VlOAulHLg/lIbZaG6gkc9Jvq49v9PZJE3EHiNyjydv73haXstptIZIyD2yLtA
 zAGvU6r+iL2rjrmkCRPKMNaSiCcrIXcbB0K9aKWM1HbzhOadlR9TkCD48KlQZPy77VEGHVlkP
 1I2oVgVPwqsKeIi+TPaVgSrGKxL8IJSL1EBOP7r6d0uMaXn1+DG4mSspdDbC5Bce2EvmLdTbl
 kcBpcKqQc+Ea10/paNsqpbftxtcWNyZ4ZA0gkfeyCv3WD9cOsdfkitw9CFrzcjz/sKM72IIms
 uQRfM5PNGbFL3wjROaByj6zZ0tX8UQGgUqqueZDkWcgAvesMWHDgslr/WGdJqToGSy2qTGZLC
 z4a+/q70Zsa68Jdkem6g==
X-Spam-Status: No, score=-100.0 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
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
X-List-Received-Date: Thu, 27 Aug 2020 08:49:21 -0000

On Aug 26 22:04, Jon Turney wrote:
> Since we recently had the unpleasant surprise of discovering that Cygwin
> doesn't build on F32 when trying to make a release, this adds some CI to
> test that.
> 
> Open issues: Since there don't seem to be RedHat packages for cocom, this
> grabs a cocom package from some random 3rd party I found on the internet.
> That might not be the best idea :).
> 
> This also updates other CI configurations.
> 
> Jon Turney (3):
>   Cygwin: Add .appveyor.yml
>   Cygwin: Add github action to cross-build on Fedora
>   Cygwin: Remove .drone.yml
> 
>  .appveyor.yml                | 69 ++++++++++++++++++++++++++++++++++++
>  .drone.yml                   | 58 ------------------------------
>  .github/workflows/cygwin.yml | 45 +++++++++++++++++++++++
>  3 files changed, 114 insertions(+), 58 deletions(-)
>  create mode 100644 .appveyor.yml
>  delete mode 100644 .drone.yml
>  create mode 100644 .github/workflows/cygwin.yml
> 
> -- 
> 2.28.0

Fine with me.  Please push.


Thanks,
Corinna
