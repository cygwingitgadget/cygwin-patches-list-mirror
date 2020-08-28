Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by sourceware.org (Postfix) with ESMTPS id D9BAE3857C5F
 for <cygwin-patches@cygwin.com>; Fri, 28 Aug 2020 08:43:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org D9BAE3857C5F
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N8XDT-1kgUpe1VMf-014TTw for <cygwin-patches@cygwin.com>; Fri, 28 Aug 2020
 10:43:07 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id B7EFBA83A7B; Fri, 28 Aug 2020 10:43:05 +0200 (CEST)
Date: Fri, 28 Aug 2020 10:43:05 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/3] CI update
Message-ID: <20200828084305.GH3272@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200826210409.2497-1-jon.turney@dronecode.org.uk>
 <20200827084918.GV3272@calimero.vinschen.de>
 <1b88af66-9b92-99a3-a4e8-4ed1a506b19a@SystematicSw.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1b88af66-9b92-99a3-a4e8-4ed1a506b19a@SystematicSw.ab.ca>
X-Provags-ID: V03:K1:oCqtSpO0Kml7jCsQSRwhckhnFnmkeibCefqu2yJC1iQH91KhWFG
 h7l2WJTzMI2ku04cJNBsWe74EAq8kCSPZZNwqg8rhDmFzYw1d7iYfncls+GYTciYoVnsEe+
 PPvTnlwFjY+Ltiutr5B2ZzqzVGbTIgNoN4dzeyfrhC6J5MKj9UIgd1Tz3821XKE7KC8CL43
 m9bOYEhYcjl4icDqNirWw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:V9VSdIkqKkY=:zBcUd5paiFTGR/zH0zXPlj
 qwse+sNzbdv/AfpO0WHUiaKcvMUaisHlUiDRFBwuT25Yis/6NJwctXi2wkR6Ofi3nqy1XMPXV
 C9YjooYcAbwXPH9VjPY/WIkrP/7zumKSWWj6Dh9psRGsC8N/MxnECjCBFoy5nOyTl//2+NGJ4
 DepXl7o1TPTD432qVbXvz0XqT1nMLjLu53VXxuPCWsXLWGX0S0ONCFwKQSyPFWO6xMFfoYEud
 INMUaWq1SWg0HZGNUFlulIaUyjc3uugLxSxUQ/x6f1y9XUwgGgcHYbCs7H7xl066DSgbbUIDd
 pDuMsBXM2n5shMgHRYay+n7+JEGIRpp9AUOMjZyXQAVmDjZNeKhln76NazA8EJI0/Ro9G2OcU
 nDumivWN8Z2UktKnsqRDg1A7Oe8XJuk2G1J1n1uVPy3oDWCTMK+UZWe3dZS105FkU9g4rdsA2
 fyIK14rQjuoFku3yCk9lTXJqW0ZSsc73AtAjqHhFqKoMzxwftz3MNpCIBuN/IgsBLvIqhvx7w
 9JEPNYNDiElv9PMpLELAtk3fvQTQzSAPDxdqd6OUi+MvKLGY7Hm8YDIEm4Z1ZjelX6XuTJMCz
 tnhVGOCLEdkdidu9iWjlhm9Xi56vc6/Cw5Um6s8BADelhtuHtkS5Q6E4Ey4V3Q3x92TCAZeFI
 //G73+/+uYo0EN5UfBzTjsSfpvARwSIeuJ7KWtV3o1Pzo5gTGnYFiNXl3tLB1iPTNR35/Z5rV
 m8r03fAY0xhEEf9xOBx/NUYdvkLVXeOuTMd/svWc2+vcd+k3cEZGLPAhd9aOj5jmJ0IJiTzsA
 QIY7yIvmu8MOInCrUwUOi1VlMUMp8CJ3mEECddzHO5mKfTpvWVZ8//ou1pJY1cuGH0h5TfXwl
 dj73v7n7rhAOoyIE2mvw==
X-Spam-Status: No, score=-100.1 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Fri, 28 Aug 2020 08:43:10 -0000

On Aug 27 13:29, Brian Inglis wrote:
> On 2020-08-27 02:49, Corinna Vinschen wrote:
> > On Aug 26 22:04, Jon Turney wrote:
> >> Since we recently had the unpleasant surprise of discovering that Cygwin
> >> doesn't build on F32 when trying to make a release, this adds some CI to
> >> test that.
> >>
> >> Open issues: Since there don't seem to be RedHat packages for cocom, this
> >> grabs a cocom package from some random 3rd party I found on the internet.
> 
> New official site V0.98 Unicode 8:
> 
> 	https://github.com/dino-lang/dino/blob/master/cocom.spec

Weird version numbering scheme.  Our cocom package is version 0.996.
Is it safe to assume this stuff is newer then ours?


Corinna
