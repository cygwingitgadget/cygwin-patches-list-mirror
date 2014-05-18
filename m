Return-Path: <cygwin-patches-return-7981-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13433 invoked by alias); 18 May 2014 19:13:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 13280 invoked by uid 89); 18 May 2014 19:13:08 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=1.2 required=5.0 tests=AWL,BAYES_20,FREEMAIL_FROM,KAM_COUK,SPF_PASS autolearn=no version=3.3.2
X-HELO: out.ipsmtp4nec.opaltelecom.net
Received: from out.ipsmtp4nec.opaltelecom.net (HELO out.ipsmtp4nec.opaltelecom.net) (62.24.202.76) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (CAMELLIA256-SHA encrypted) ESMTPS; Sun, 18 May 2014 19:13:06 +0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApMBAJQFeVNV0kaZ/2dsb2JhbAANTINVxA+Bc4QYPRYYAwIBAgFYBgIBAYhKrBCkfReObYQqBJE6hCSFOZUVbAE
X-IPAS-Result: ApMBAJQFeVNV0kaZ/2dsb2JhbAANTINVxA+Bc4QYPRYYAwIBAgFYBgIBAYhKrBCkfReObYQqBJE6hCSFOZUVbAE
Received: from 85-210-70-153.dynamic.dsl.as9105.com (HELO [127.0.0.1]) ([85.210.70.153])  by out.ipsmtp4nec.opaltelecom.net with ESMTP; 18 May 2014 20:13:02 +0100
Message-ID: <5379063B.3000101@tiscali.co.uk>
Date: Sun, 18 May 2014 19:13:00 -0000
From: David Stacey <drstacey@tiscali.co.uk>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] Buffer over-run fix for getusershell(3)
Content-Type: multipart/mixed; boundary="------------080305030205050704070704"
X-IsSubscribed: yes
X-SW-Source: 2014-q2/txt/msg00004.txt.bz2

This is a multi-part message in MIME format.
--------------080305030205050704070704
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 1253

This is the first patch resulting from the Coverity Scan analysis of the 
Cygwin source code. The patch fixes Coverity ID 59932. Note that we 
don't have that many bugs in the Cygwin source code - that's just an ID 
that Coverity assigned to this issue. The patch is only a single line, 
so it falls into our definition of 'trivial'.

getusershell(3) returns the next line from the '/etc/shells' file [1]. 
This contains a path to an executable, so it makes sense for 'buf' to 
contain PATH_MAX characters.

Now, the definition of PATH_MAX is the maximum length of the path, 
including the null terminator [2]. So the for() loop should copy 
PATH_MAX-1 characters, in order to allow for the null terminator.

However, by copying PATH_MAX characters, there is a possible buffer 
over-run when the null terminator is applied. The patch (attached) 
corrects this.

Change Log:
2014-05-18  David Stacey  <drstacey@tiscali.co.uk>

         * winsup/cygwin/syscalls.cc(getusershell) :
         Fixed theoretical buffer overrun of 'buf' that would occur if
         /etc/shells contained a line longer than 4095 characters.

Cheers,

Dave.

[1] http://linux.die.net/man/3/getusershell
[2] http://pubs.opengroup.org/onlinepubs/009695399/basedefs/limits.h.html


--------------080305030205050704070704
Content-Type: text/plain; charset=windows-1252;
 name="getusershell_buffer_overrun.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="getusershell_buffer_overrun.patch"
Content-length: 568

--- cygwin-orig-src/winsup/cygwin/syscalls.cc	2014-05-14 12:29:12.000000000 +0100
+++ cygwin-src/winsup/cygwin/syscalls.cc	2014-05-18 19:43:18.355953300 +0100
@@ -4179,7 +4179,7 @@
   /* Get each non-whitespace character as part of the shell path as long as
      it fits in buf. */
   for (buf_idx = 0;
-       ch != EOF && !isspace (ch) && buf_idx < PATH_MAX;
+       ch != EOF && !isspace (ch) && buf_idx < (PATH_MAX - 1);
        buf_idx++, ch = getc (shell_fp))
     buf[buf_idx] = ch;
   /* Skip any trailing non-whitespace character not fitting in buf.  If the

--------------080305030205050704070704--
