(function () {
  const USER_KEY = "internal_bot_user_id";

  function getOrCreateUserId() {
    const existing = window.localStorage.getItem(USER_KEY);
    if (existing) return existing;

    const created = `emp-${Date.now()}-${Math.random().toString(36).slice(2, 10)}`;
    window.localStorage.setItem(USER_KEY, created);
    return created;
  }

  window.GovBotWidget = {
    getUserId: getOrCreateUserId,
  };
})();
