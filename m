Return-Path: <cygwin-patches-return-8851-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 44256 invoked by alias); 10 Sep 2017 04:11:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 44033 invoked by uid 89); 10 Sep 2017 04:11:04 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.0 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW autolearn=no version=3.3.2 spammy=Hx-languages-length:1186, HTo:U*cygwin-patches, HContent-Transfer-Encoding:8bit
X-HELO: smtp-out-so.shaw.ca
Received: from smtp-out-so.shaw.ca (HELO smtp-out-so.shaw.ca) (64.59.136.138) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 10 Sep 2017 04:11:03 +0000
Received: from [192.168.1.100] ([24.64.240.204])	by shaw.ca with SMTP	id qtaGdls19DJTWqtaHdioR9; Sat, 09 Sep 2017 22:11:01 -0600
X-Authority-Analysis: v=2.2 cv=B4DJ6KlM c=1 sm=1 tr=0 a=MVEHjbUiAHxQW0jfcDq5EA==:117 a=MVEHjbUiAHxQW0jfcDq5EA==:17 a=IkcTkHD0fZMA:10 a=b4eMD0GmHX_ZvWjD-W0A:9 a=QEXdDO2ut3YA:10
Reply-To: Brian.Inglis@SystematicSw.ab.ca
To: cygwin-patches@cygwin.com
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Subject: =?UTF-8?Q?fhandler=5fdsp.cc_error:_nonnull_argument_=e2=80=98this?= =?UTF-8?Q?=e2=80=99_compared_to_NULL?=
Message-ID: <987d64f0-88dd-d11d-d52b-5e20c9957193@SystematicSw.ab.ca>
Date: Thu, 14 Sep 2017 12:42:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfBQdAFfMu3V/TqYS6qKVvk2B4jdt+FouHKGd5QWVXCxJYMJWEb9YVLU7H9wdNMkPV+/jw5Baf3ilbAnZxNz66BcRB2HU8BDGWcgeQDPB28i5o+dTW7An vyHZC+Owb4DRMEIk3W+uWKcbj9axLkU9Kqpuw0qw9cGExhJRTK5aBLZ7rGLH//sgFS8nkC/dBCyZYw9FQkSOGpNy/9nQ2JcQDkM=
X-IsSubscribed: yes
X-SW-Source: 2017-q3/txt/msg00053.txt.bz2

Getting failure building latest git with current gcc 6.3
...
c++wrap -O2 -g -fno-rtti -fno-exceptions -fno-use-cxa-atexit -Wall
-Wstrict-aliasing -Wwrite-strings -fno-common -pipe -fbuiltin -fmessage-length=0
-MMD -Werror -fmerge-constants -ftracer -c -o fhandler_dsp.o
../../.././winsup/cygwin/fhandler_dsp.cc
../../.././winsup/cygwin/fhandler_dsp.cc: In member function âvoid
fhandler_dev_dsp::Audio_out::buf_info(audio_buf_info*, int, int, int)â:
../../.././winsup/cygwin/fhandler_dsp.cc:503:3: error: nonnull argument âthisâ
compared to NULL [-Werror=nonnull-compar ]
   if (this && dev_)
   ^~
../../.././winsup/cygwin/fhandler_dsp.cc: In member function âvoid
fhandler_dev_dsp::Audio_in::buf_info(audio_buf_info*, int, int, int)â:
../../.././winsup/cygwin/fhandler_dsp.cc:960:3: error: nonnull argument âthisâ
compared to NULL [-Werror=nonnull-compar ]
   if (this && dev_)
   ^~
cc1plus: all warnings being treated as errors
make[3]: *** [../../.././winsup/cygwin/../Makefile.common:41: fhandler_dsp.o]
Error 1

$ gcc --version
gcc (GCC) 6.3.0

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada
