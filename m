Return-Path: <cygwin-patches-return-5334-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2957 invoked by alias); 7 Feb 2005 16:55:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2861 invoked from network); 7 Feb 2005 16:55:21 -0000
Received: from unknown (HELO omzesmtp03.mci.com) (199.249.17.11)
  by sourceware.org with SMTP; 7 Feb 2005 16:55:21 -0000
Received: from pmismtp01.mcilink.com ([166.38.62.36])
 by firewall.mci.com (Iplanet MTA 5.2)
 with ESMTP id <0IBJ00A3WVDXA4@firewall.mci.com> for
 cygwin-patches@sources.redhat.com; Mon, 07 Feb 2005 16:34:45 +0000 (GMT)
Received: from pmismtp01.mcilink.com by pmismtp01.mcilink.com
 (iPlanet Messaging Server 5.2 HotFix 1.14 (built Mar 18 2003))
 with SMTP id <0IBJ00201VD9R7@pmismtp01.mcilink.com> for
 cygwin-patches@sources.redhat.com; Mon, 07 Feb 2005 16:34:45 +0000 (GMT)
Received: from WS117V6220509.mcilink.com ([166.34.133.100])
 by pmismtp01.mcilink.com
 (iPlanet Messaging Server 5.2 HotFix 1.14 (built Mar 18 2003))
 with ESMTP id <0IBJ002LCVDB2K@pmismtp01.mcilink.com> for
 cygwin-patches@sources.redhat.com; Mon, 07 Feb 2005 16:34:23 +0000 (GMT)
Date: Mon, 07 Feb 2005 16:55:00 -0000
From: Mark Paulus <mark.paulus@mci.com>
Subject: patch to allow touch to work on HPFS (and others, maybe??)
To: Cygwin Patches <cygwin-patches@sources.redhat.com>
Message-id: <0IBJ002LDVDB2K@pmismtp01.mcilink.com>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_G91385RHgnVSnWz/kjZC0g)"
Priority: Normal
X-SW-Source: 2005-q1/txt/msg00037.txt.bz2


--Boundary_(ID_G91385RHgnVSnWz/kjZC0g)
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7bit
Content-length: 230

Attached is a patch that works to allow me to do a 
touch on my mounted HPFS filesystem.  I'm not sure
about clearcase, or others, but it works on HPFS and
NTFS. 

	* times.cc: Use GENERIC_WRITE instead of FILE_WRITE_ATTRIBUTES.


--Boundary_(ID_G91385RHgnVSnWz/kjZC0g)
Content-type: application/octet-stream; name=times.cc.patch
Content-transfer-encoding: base64
Content-disposition: attachment; filename=times.cc.patch
Content-length: 789

LS0tIC4uLy4uLy4uL3NyYy5taW5lL3dpbnN1cC9jeWd3aW4vdGltZXMuY2MJ
MjAwNS0wMi0wNyAwODowNToyNy43OTM0OTcxMDAgLTA3MDAKKysrIHRpbWVz
LmNjCTIwMDUtMDItMDcgMDg6NTY6MzYuNTk2NzIyODAwIC0wNzAwCkBAIC00
NjMsNyArNDYzLDcgQEAgdXRpbWVzIChjb25zdCBjaGFyICpwYXRoLCBzdHJ1
Y3QgdGltZXZhbAogICAgICB0aGUgdGltZXMgb2YgZGlyZWN0b3JpZXMuICAq
LwogICAvKiBOb3RlOiBJdCdzIG5vdCBkb2N1bWVudGVkIGluIE1TRE4gdGhh
dCBGSUxFX1dSSVRFX0FUVFJJQlVURVMgaXMKICAgICAgc3VmZmljaWVudCB0
byBjaGFuZ2UgdGhlIHRpbWVzdGFtcHMuLi4gKi8KLSAgSEFORExFIGggPSBD
cmVhdGVGaWxlICh3aW4zMiwgRklMRV9XUklURV9BVFRSSUJVVEVTLAorICBI
QU5ETEUgaCA9IENyZWF0ZUZpbGUgKHdpbjMyLCBHRU5FUklDX1dSSVRFLAog
CQkJIEZJTEVfU0hBUkVfUkVBRCB8IEZJTEVfU0hBUkVfV1JJVEUsCiAJCQkg
JnNlY19ub25lX25paCwgT1BFTl9FWElTVElORywKIAkJCSBGSUxFX0FUVFJJ
QlVURV9OT1JNQUwgfCBGSUxFX0ZMQUdfQkFDS1VQX1NFTUFOVElDUywK

--Boundary_(ID_G91385RHgnVSnWz/kjZC0g)--
