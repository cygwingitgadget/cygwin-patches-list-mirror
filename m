Return-Path: <cygwin-patches-return-4777-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3093 invoked by alias); 19 May 2004 16:55:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3082 invoked from network); 19 May 2004 16:55:26 -0000
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: Question concerning SSHD on CYGWIN
Date: Wed, 19 May 2004 16:55:00 -0000
Message-ID: <2A9F70D12FA9034E8D9EF31894A0B22F27CEA1@bbnexc03.emea.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
From: "Kleinert, Marcel" <marcel.kleinert@hp.com>
To: <cygwin-patches@cygwin.com>
Cc: "Kleinert, Marcel" <marcel.kleinert@hp.com>
X-OriginalArrivalTime: 19 May 2004 16:55:25.0882 (UTC) FILETIME=[150511A0:01C43DC2]
X-SW-Source: 2004-q2/txt/msg00129.txt.bz2

Hello,
=20
For a internal prototype we are using cygwin on a windows 2000 system to
transfer data via ssh from one windows machine to this windows system
with   cygwin sshd.
=20
If we have alot of data to transfer (e.g. 800 MB) after approximately 10
minutes the transfer hangs
without an exception.=20
=20
So I opened the log file for sshd on the cygwin folder on the target
machine. In this log file=20
I have the following messages:
=20
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 9 [sig] sshd 2148 wait_sig: short read from signal pipe: 1 !=3D 20
   3583 [sig] sshd 2148 wait_sig: short read from signal pipe: 2 !=3D 20
1237139 [sig] sshd 2148 wait_sig: short read from signal pipe: 1 !=3D 20
1245150 [sig] sshd 2148 wait_sig: short read from signal pipe: 2 !=3D 20
1529145 [sig] sshd 2148 wait_sig: short read from signal pipe: 1 !=3D 20
1536801 [sig] sshd 2148 wait_sig: short read from signal pipe: 2 !=3D 20
3581925 [sig] sshd 2148 wait_sig: short read from signal pipe: 1 !=3D 20
3591269 [sig] sshd 2148 wait_sig: short read from signal pipe: 2 !=3D 20
6645385 [sig] sshd 2148 wait_sig: short read from signal pipe: 1 !=3D 20
6883663 [sig] sshd 2148 wait_sig: short read from signal pipe: 1 !=3D 20
      9 [main] sshd 3684 sig_send: error sending signal 28 to pid 3684,
pipe handle 0x300, Win32 error 5
 561758 [proc] sshd 3684 sig_send: error sending signal 20 to pid 3684,
pipe handle 0x300, Win32 error 5
   7482 [main] sshd 1556 sig_send: error sending signal 28 to pid 1556,
pipe handle 0x300, Win32 error 5
 474317 [proc] sshd 1556 sig_send: error sending signal 20 to pid 1556,
pipe handle 0x300, Win32 error 5
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
=20
I am not really sure what the problem is. I also tried to transfer the
data to a unix ssh daemon.
With this daemon I had no problems. The whole 800 MB was transferred
successfully.
=20
Do you think thats a bug in the ssh daemon of cygwin? And if it is a bug
to you know how to fix it ?
=20
Thanks alot for your help in advance.
=20
 Marcel Kleinert=20
