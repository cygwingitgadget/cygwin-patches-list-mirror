Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	by sourceware.org (Postfix) with ESMTPS id 5ADA63858D37
	for <cygwin-patches@cygwin.com>; Mon,  3 Apr 2023 13:29:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5ADA63858D37
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MSKly-1pptpL47A0-00SgSU; Mon, 03 Apr 2023 15:29:16 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 70E56A80CED; Mon,  3 Apr 2023 15:29:15 +0200 (CEST)
Date: Mon, 3 Apr 2023 15:29:15 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 3/3] Respect `db_home: env` even when no uid can be
 determined
Message-ID: <ZCrUq1P4kOr7D44O@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	cygwin-patches@cygwin.com
References: <cover.1663761086.git.johannes.schindelin@gmx.de>
 <cover.1679991274.git.johannes.schindelin@gmx.de>
 <4cd6ae73074f327064b54a08392906dbc140714a.1679991274.git.johannes.schindelin@gmx.de>
 <ZCK+v7yBxRBft3UK@calimero.vinschen.de>
 <97e5226e-60c6-9d03-0c71-72e3192abe59@gmx.de>
 <8b84ada5-ae6c-febf-e412-365fe2f919fe@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8b84ada5-ae6c-febf-e412-365fe2f919fe@gmx.de>
X-Provags-ID: V03:K1:naX3OAnaninh7G5GjWcZfEjRiRyD1gQ576kI/3L4wS4ps9KnP+i
 0yz6dsHOEE/OZ10IsJZtTNGatIeEaNmMucxDdpigN2cUn3PENBSRI1e7V/7ATPf51Up0/8n
 eCBHJwiGB1JjvqWvMO9ycrUxLlbltN63j4PHMZBTjq0jio6mDxjEcA9EAUp6F2Ue64llB2F
 K+eIIHO7EDjfsLKjWQZ/g==
UI-OutboundReport: notjunk:1;M01:P0:BAsXOCs9pjw=;+MEQDSlEVdtGh5vWVnbTg7D1ikD
 fU3bg7NyNj2pGttRtrPpdmZIFNKTUPnukIqGaf0ZqyLWB04gxpfL7RhALzvsYdghBE7pLbRud
 4PVjPaJ7i52HS4dnvABI9/EH6o2dTCM0C5IDXfPYXieAPo+AqCAVpeWvUfgMdCJS4V60lH9kE
 PU+LCjrEojjnT5eLuI/227JanJSAgsL81k5WLsbwq7ASQD8cBL1NKHrB8OT6tXAKwBUlxtW3h
 AQ1CGld4cXANbtZ8myh53tkxuqlZyF70NJs3Qnlfn4yxOIiHro87xXLfScLKiV2JuM2JZpEfV
 b2WiktG/Gf/UjJPPOi7LWEyu5psgZeIF7Qc4D+oeXoMer5V4tAfWRxSwq7PG1DaEXi6TtzK0G
 Om7p5lGAlPYwdmrVdkSd3AvlAxsO/GCrSRx3Vhf3GfEKhFfXhGxEctfhPuaCGO0TEMPxDLazj
 aPQphqdNcAzpPGY3PyNS6D5mzZCPn7ab7sTHC7I0FnXlGJJleHdUnybrbIyCwgOM0CNgOk6uo
 JMA+ONkaR9H50kWV4shICe4uM8vhFgIja/OkiB9Nb+EbNO+v0YKUnmyzCtgR5WgXD1R0i5ptz
 BGzuexLcpgLotpqUTslAZTgTlGu+Mwu6CvG58kaXWSQ5sW6qnFfEJXa/vreklxCZ69gH7ryU9
 APsNvXmmOiqXB1Ee+DV5fRlAuD1LrT3bhHEqIAxPcQ==
X-Spam-Status: No, score=-97.7 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_NONE,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Apr  3 15:12, Johannes Schindelin wrote:
> Hi Corinna,
> 
> On Mon, 3 Apr 2023, Johannes Schindelin wrote:
> 
> > On Tue, 28 Mar 2023, Corinna Vinschen wrote:
> >
> > > On Mar 28 10:17, Johannes Schindelin wrote:
> > > > In particular when we cannot figure out a uid for the current user, we
> > > > should still respect the `db_home: env` setting. Such a situation occurs
> > > > for example when the domain returned by `LookupAccountSid()` is not our
> > > > machine name and at the same time our machine is no domain member: In
> > > > that case, we have nobody to ask for the POSIX offset necessary to come
> > > > up with the uid.
> > > >
> > > > It is important that even in such cases, the `HOME` environment variable
> > > > can be used to override the home directory, e.g. when Git for Windows is
> > > > used by an account that was generated on the fly, e.g. for transient use
> > > > in a cloud scenario.
> > >
> > > How does this kind of account look like?  I'd like to see the contants
> > > of name, domain, and the SID.  Isn't that just an account closely
> > > resembling Micorosft Accounts or AzureAD accounts?  Can't we somehow
> > > handle them alike?
> >
> > [...]
> >
> > What I _can_ do is try to recreate the problem (the report said that this
> > happens in a Kudu console of an Azure Web App, see
> > https://github.com/projectkudu/kudu/wiki/Kudu-console) by creating a new
> > Azure Web App and opening that console and run Cygwin within it, which is
> > what I am going to do now.
> 
> So here is what is going on:
> 
> - The domain is 'IIS APPPOOL'

There's a domain, so why not pass it to the called function?>

> - The name is the name of the Azure Web App
> 
> - The sid is 'S-1-5-82-3932326390-3052311582-2886778547-4123178866-1852425102'

Oh well. These are basically the same thing as 1-5-80 service accounts.
It would be great if we could handle them gracefully instead of
special-case them in a piece of code we just reach because we don't
handle them yet.

Btw., one easy way out would be if we default to /home/<name> or
/home/<SID> rather than "/", isn't it?


Corinna
