Return-Path: <cygwin-patches-return-7460-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15736 invoked by alias); 31 Jul 2011 09:25:02 -0000
Received: (qmail 15716 invoked by uid 22791); 31 Jul 2011 09:25:01 -0000
X-SWARE-Spam-Status: No, hits=-1.0 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,TW_DB,TW_LG,TW_XD,T_TO_NO_BRKTS_FREEMAIL
X-Spam-Check-By: sourceware.org
Received: from mail-pz0-f52.google.com (HELO mail-pz0-f52.google.com) (209.85.210.52)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 31 Jul 2011 09:24:47 +0000
Received: by pzd13 with SMTP id 13so9737953pzd.11        for <cygwin-patches@cygwin.com>; Sun, 31 Jul 2011 02:24:47 -0700 (PDT)
Received: by 10.142.249.37 with SMTP id w37mr1649784wfh.448.1312104148767;        Sun, 31 Jul 2011 02:22:28 -0700 (PDT)
Received: from [192.168.1.2] ([183.106.96.61])        by mx.google.com with ESMTPS id v17sm2353191wfd.5.2011.07.31.02.22.26        (version=SSLv3 cipher=OTHER);        Sun, 31 Jul 2011 02:22:27 -0700 (PDT)
Message-ID: <4E351EEB.4090300@gmail.com>
Date: Sun, 31 Jul 2011 09:25:00 -0000
From: jojelino <jojelino@gmail.com>
User-Agent: Mozilla/5.0 (Windows NT 5.2; rv:7.0a2) Gecko/20110730 Thunderbird/7.0a2
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] you can use this patch to profile cygwin-2
References: <4E329C56.8090605@gmail.com> <20110730210453.GB31551@ednor.casa.cgf.cx> <20110731082623.GA23964@calimero.vinschen.de>
In-Reply-To: <20110731082623.GA23964@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q3/txt/msg00036.txt.bz2

On 2011-07-31 PM 6:16, jojelino wrote:
 > # in i686-pc-cygwin/winsup/cygwin/Makefile, you should add CFLAGS '-pg
 > -finstrument-functions' , to make new profiling code effective.
 > and comment out ifneq "${filter -O%,$(CFLAGS)}" "" too. it would make
 > profiling code functional ( in cases you need to profile cygheap thread
 > etc...)
I missed important one.
Please find rule in Makefile and apply following.

# Rule to build cygwin.dll
$(TEST_DLL_NAME): $(LDSCRIPT) dllfixdbg $(DLL_OFILES) $(DLL_IMPORTS) 
$(LIBSERVER) $(LIBC) $(LIBM) $(API_VER) Makefile winver_stamp
	$(CXX) $(CXXFLAGS) -Wl,--gc-sections $(nostdlib) -Wl,-T$(firstword $^) \
	-Wl,--heap=0 -Wl,--out-implib,cygdll.a -shared -o $@ \
  -e $(DLL_ENTRY) $(DEF_FILE) gcrt1.o $(DLL_OFILES) version.o winver.o \
  $(MALLOC_OBJ) $(LIBSERVER) $(LIBM) $(LIBC) boundbuffer.o instrument.o 
gmon.o mcount.o profil.o /lib/w32api/libkernel32.a \
  -lgcc $(DLL_IMPORTS) -Wl,-Map,cygwin.map
  @$(word 2,$^) $(OBJDUMP) $(OBJCOPY) $@ ${patsubst %0.dll,%1.dbg,$@}
  @ln -f $@ new-$(DLL_NAME)
