Return-Path: <cygwin-patches-return-3378-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8591 invoked by alias); 11 Jan 2003 15:28:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8582 invoked from network); 11 Jan 2003 15:28:19 -0000
Message-Id: <3.0.5.32.20030111102758.007e1100@h00207811519c.ne.client2.attbi.com>
X-Sender: pierre@h00207811519c.ne.client2.attbi.com
Date: Sat, 11 Jan 2003 15:28:00 -0000
To: Corinna Vinschen <cygwin-patches@cygwin.com>
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: patch 3: sshd
In-Reply-To: <20030111142035.A11998@cygbert.vinschen.de>
References: <3DD15A2F.B79E5376@ieee.org>
 <3DD15A2F.B79E5376@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q1/txt/msg00027.txt.bz2

At 02:20 PM 1/11/2003 +0100, you wrote:
>Btw., I applied that patch to 3.5p1-3 and I've send it to the openssh
>developers list.

OK thanks, I will send you what's needed on the Cygwin side.
su now works on Cygwin, at least on 95/98/ME!

About the gethostname issue, I changed the name of the WinME
computer using the control panel and rebooted. That got rid of 
the Marie-Claire entry in the registry and gethostname now
displays the correct name in lower case. 
So it's fine with me to change uname, but let's be ready for 
questions on the list.  

Pierre
