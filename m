Return-Path: <SRS0=BBfk=HO=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo007.btinternet.com (btprdrgo007.btinternet.com [65.20.50.168])
	by sourceware.org (Postfix) with ESMTP id 10D2C4B9DB66
	for <cygwin-patches@cygwin.com>; Tue, 22 Sep 2026 17:37:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 10D2C4B9DB66
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 10D2C4B9DB66
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.168
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1790098668; cv=none;
	b=OkIeWiPP9IzC7U8xYWL3bhMPaB4KRUsBDaOI3hFL76IwbOtTACsmHEvlYQQlN7itsBmAPImSou+r0ubkOOJkvl4MRH19KkkAhJGwWMLugJpittnZVdBhiXvHN9f9FtKiM49buVA0LIdNp75zJvsqmkvrc6Vokp06/G72NmeJzdY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790098668; c=relaxed/simple;
	bh=UeOvuzupaIjuKu/Be7M37bBdQuWv5ucdeceKCfGpdi0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=E93XkEyBhsn+MP9m/0kdrUkALHyQhXRVXFA73tWi9Onh+HmZs622VBJy8MbskZWxHdwh6bCUmnE2OHZ0LNqkmXP4Dw1wT6QVKxewh8BadCInxnhf6x+aGXBfVNyYZIgynn9AaU78BoRHWrS4sa/93jA3Imv25jGTPps2hPEhX3g=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 10D2C4B9DB66
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A715EB8096817E8
X-Originating-IP: [62.56.83.178]
X-OWM-Source-IP: 62.56.83.178
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: dmFkZTEccmguqfe4pSFhp7PbzZws0Hk2B5ZZEfZ009AA2cMluuCZvGBcW6cUfD/PNNfBqPbaHZf0YnOcRLWz/MSu5T1rzuZ2cN5Q7eGt8i3bLO4z5k7O9gHLYEN9kPWkNi1bVHiVMKiE1e5Oqsw6rlUS5Co/9SzEYtsl/pgn8OiU5ZxDl8s2+yB4vF26pSTc0sZR/B0ynwvx9sM/stLZJdSntsdYKFyKztCn9BGwN862z39VXLpKbL7k9xol94AbwD29BOkxR8eLeUJX7EMjVYAG00ElUCZRLk68DX1cXKyfPTz3b8iE6VoBmU2nGFDVFlzDxvDeqDIQjm4YmqtMpaymSD2qKd0Q6Igp4mKDpvCBPoocibKyMZQno+9pJqRBgWwP7sU+ECEbR8zdD66RsdQWPFHB/kZMZ4BXyxFLVeiSXgM8kCL2D1E6YTQNWdJbEoiLaYmXj4aEaWwYptIC3BpW4EJ2hv1nS/hlsCzDs0wYw9hwdqKSmZKzrOdaE4BIHOu5cqqBWDNiB76hnCIzbjdwfkpunO2B1yg7t/5lrm/Qcu0SG3q4afyXmL5lBcV2pujJlIaIdfWbiwUNxBAd9rG7I9cvCzXVezWdx7hNhF0ZjpeTu18eYOkXjgoczkKhavg8pVgBAtoFVYxyZX2ZFDLy7e15vsTcAzmm/kYZRorYuj6k9A
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from tambora (62.56.83.178) by btprdrgo007.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A715EB8096817E8; Tue, 22 Sep 2026 18:37:44 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 0/3] Fix "unused but set variable" warnings with gcc 16
Date: Tue, 22 Sep 2026 18:37:34 +0100
Message-ID: <20260922173737.111763-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,KAM_NUMSUBJECT,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Jon Turney (3):
  Cygwin: Variable 'looped' computed but never used
  Cygwin: Variable 'prot' computed but never used
  Cygwin: Variable 'nfences' computed but never used

 winsup/cygserver/sysv_shm.cc | 6 ++++++
 winsup/cygwin/mm/malloc.cc   | 4 ++++
 winsup/cygwin/spawn.cc       | 2 --
 3 files changed, 10 insertions(+), 2 deletions(-)

-- 
2.51.0

