(function() {
  var Example,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  Example = (function() {
    function Example($el, type) {
      this.autoUpdate = bind(this.autoUpdate, this);
      this.el = $el;
      this.type = type;
      this.select = $el.find('.example__select');
      this.list = $el.find('.example__list');
      this.autoUpdate();
    }

    Example.prototype.autoUpdate = function() {
      var currentState;
      currentState = this.select.val();
      return this.select.off('change').on('change', (function(_this) {
        return function() {
          _this.list.removeClass('f-' + _this.type + '--' + currentState);
          _this.list.addClass('f-' + _this.type + '--' + _this.select.val());
          return _this.autoUpdate();
        };
      })(this));
    };

    return Example;

  })();

  new Example($('.example--align'), 'align');

  new Example($('.example--dir'), 'dir');

  new Example($('.example--gap'), 'gap');

}).call(this);
