Return-Path: <cygwin-patches-return-1870-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 14576 invoked by alias); 19 Feb 2002 00:40:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14515 invoked from network); 19 Feb 2002 00:40:27 -0000
Subject: Re: [PATCH]setup.exe passwd-grp.bat being created when not needed
From: Robert Collins <robert.collins@itdomain.com.au>
To: Michael A Chase <mchase@ix.netcom.com>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <002801c1b8d0$0042a300$f400a8c0@mchasecompaq>
References: <002801c1b8d0$0042a300$f400a8c0@mchasecompaq>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: Tue, 19 Feb 2002 14:54:00 -0000
Message-Id: <1014079272.2005.3.camel@lifelesswks>
Mime-Version: 1.0
X-OriginalArrivalTime: 19 Feb 2002 00:40:26.0107 (UTC) FILETIME=[05B4CCB0:01C1B8DE]
X-SW-Source: 2002-q1/txt/msg00227.txt.bz2

On Tue, 2002-02-19 at 09:59, Michael A Chase wrote:
> Currently /etc/postinstall/passwd-grp.bat is opened before the need for it
> is determined.  This results in the file always being executed even though
> it is normally empty.   This patch may eliminate the flashing console window
> at the end of setup.exe when no action is expected.
> 
> I left the iostream::mkpath_p() call at the top of the function to make sure
> /etc/postinstall/ always exists after make_passwd_group() is called.  This
> appears to be the only place the directory is created explicitly.
> 
> Sorry for the separate patches.  The two issues are independent and I didn't
> notice this until I'd already sent the previous patch.  The patches may be
> combined if you wish.

Actually, I prefer separate patchs - it's easier to pick n choose.
Thanks.

Both applied.

Rob

