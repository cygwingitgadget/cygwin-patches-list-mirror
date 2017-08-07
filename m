Return-Path: <cygwin-patches-return-8814-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27741 invoked by alias); 6 Aug 2017 13:57:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 27656 invoked by uid 89); 6 Aug 2017 13:57:54 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-11.2 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_LOW,RP_MATCHES_RCVD,SPF_PASS autolearn=ham version=3.3.2 spammy=winsup, Hx-languages-length:1791, H*F:D*web.de, HX-Priority:Normal
X-HELO: mout.web.de
Received: from mout.web.de (HELO mout.web.de) (212.227.17.11) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 06 Aug 2017 13:57:52 +0000
Received: from [10.224.6.252] ([185.80.169.68]) by smtp.web.de (mrweb102 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M6mPA-1dQHeK37mm-00wXPf for <cygwin-patches@cygwin.com>; Sun, 06 Aug 2017 15:57:48 +0200
Date: Mon, 07 Aug 2017 09:31:00 -0000
From: Simon <HeinisMail@web.de>
Message-ID: <35088024.20170806155704@web.de>
To: cygwin-patches@cygwin.com
Subject: rmdir: improvement for emptiness check
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-UI-Out-Filterresults: notjunk:1;V01:K0:cgQP9H2a8lM=:su+H+j0sq5Xfarx+VqwTjb 1OPbnLPR5wWtN2sKLXa3bzvlRTRCzvALSiY/OzlDOQAGGuvYlU00eZg8PCJwGoRArxT+JL79f VVIdKr9ZPw+/xgeMBpz26pf1NN5MdxSkD4OoZ4DbhaSkpJnFbGWon93G3UBYpfIGaX+cC7zy4 9TcIFxOvIGvJNp0GM4j//UoTeiwomF13kBzqo53ArHnis/vyo51V9DrAQb/vUBh67NcBOgx8u DOmp3Yq8MPdvg+dWkWc5fmUNv7v63Hj+2W2KMDReqPkRrAfaVi9IJLQjPnhjYrGm+lrVVtXkI vWFgdKE4Y5XLOe2S/ml67A78a3iyWI6ZVmXXn+mEIxV/siefFEXw8uz22+05TFyiccpxKVHOy 7jcwSzy/jpXNBgxx33rE5F+m6sXcXTbTf6EX865ugyNdnEmNbX39pr33sdQH8UtKl6emPSlmL aURU/jc7jqY92ygsenv8NRJ28IHmpcqgQcT0BwMqQxXnvNA2002t5S++JoFoaJmh29bVztpao Njaxj20V0WNOd93rIqXqkgc1Cw/7xyS/E3hfI2gNDFHsh/2MK9aFtU8YDxKZcqK7Xb7MPmj+K Vhc1+IbDsXBIZykZAullceuNildthUAd9xA+LHSnLDK/QshPih1ivXP3pCzbG6Og77O7HY5kz qDMm8AZtd71+VTlmy7XXygNdww2f3aBwnLtd4AmE8GCsCgUxTnQ3J3XwK/3GQ0pofKxxYzv+o 2+kK+JuH5NGmkNp30FFQAcjCUgpOaoO7J48K2Y84RoZp2UfDKeHqkS4b0+Ub6AHAgYY8Vwv8p vxq+c0B6Rb2n8vhSMvfKf3K1jCGooSyGxP91WxEs4dvamXgoYM=
X-IsSubscribed: yes
X-SW-Source: 2017-q3/txt/msg00016.txt.bz2

Dear list,

when deleting a directory, cygwin checks if the directory is empty.
When doing so, it skipped every second file found in that directory
(note the repetition of the line "pfni = ...NextEntryOffset"). This is
a problem when, e.g., there are two files in that directory and the
first one is in a PENDING_DELETE state. The second one will not be
tested, so the directory is considered empty.

This is not an urgent patch, but fixing this should lower the
probability of an accidentally, temporarily "deleted" directory (i.e.
1. think it is empty; 2. move to recycle bin; 3. check again; 4.
notice the error and move back to its old location).

NB.: The whole move-to-bin strategy is broken and maybe even
unfounded. I don't know why cygwin is trying to move an empty
directory to a recycle.bin folder. The inherent race condition seems
avoidable to me. Is there a discussion regarding that behaviour?

Simon

--- a/winsup/cygwin/syscalls.cc 2017-07-19 10:42:02.000000000 +0200
+++ b/winsup/cygwin/syscalls.cc 2017-08-06 14:41:48.000000000 +0200
@@ -586,14 +586,14 @@
     {
       while (pfni->NextEntryOffset)
        {
+         pfni = (PFILE_NAMES_INFORMATION) ((caddr_t) pfni + pfni->NextEntryOffset);
+         /* skipping first two entries: "." and ".." */
          if (++cnt > 2)
            {
              UNICODE_STRING fname;
              OBJECT_ATTRIBUTES attr;
              FILE_BASIC_INFORMATION fbi;

-             pfni = (PFILE_NAMES_INFORMATION)
-                    ((caddr_t) pfni + pfni->NextEntryOffset);
              RtlInitCountedUnicodeString(&fname, pfni->FileName,
                                          pfni->FileNameLength);
              InitializeObjectAttributes (&attr, &fname, 0, dir, NULL);
@@ -627,7 +627,6 @@
                  return STATUS_DIRECTORY_NOT_EMPTY;
                }
            }
-         pfni = (PFILE_NAMES_INFORMATION) ((caddr_t) pfni + pfni->NextEntryOffset);
        }
     }
   while (NT_SUCCESS (NtQueryDirectoryFile (dir, NULL, NULL, 0, &io, pfni,
